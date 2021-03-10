class MainMenu < UserInterface
  include ExceptionHadler

  def initialize
    super
    action_select
  end

  MAINMENU = { '1' => { 'action' => 'show_all_input', 'text' => 'stations/routes/trains enter' },
               '2' => { 'group' => 'station_int', 'method' => 'create_station', 'text' => 'Create station' },
               '3' => { 'action' => 'create_route', 'text' => 'Create route'},
               '4' => { 'action' => 'create_train', 'text' => 'Create train' },
               '5' => { 'group' => 'route_int', 'method' => 'route_edit', 'text' => 'Change/add station to Route'},
               '6' => { 'action' => 'trains_on_station', 'text' => 'List trains in station' },
               '7' => { 'action' => 'train_direction_select', 'text' => 'Move train' },
               '8' => { 'action' => 'add_delete_train_car', 'text' => 'Add/delete train cars' },
               '9' => { 'action' => 'train_add_route', 'text' => 'Add route to train' },
               '10' => { 'action' => 'train_add_manufacturer', 'text' => 'Add train manufacture' },
               '11' => { 'action' => 'train_find', 'text' => 'Find train by number' },
               '12' => { 'action' => 'instances_number', 'text' => 'Instance number of Stations/Routes/Trains' },
               '13' => { 'action' => 'block_it', 'text' => 'Apple block to all Stations/Trains' },
               '14' => { 'action' => 'show_train', 'text' => 'Show Train cars' },
               '15' => { 'action' => 'add_delete_train_car', 'text' => 'Add load for train cars enter' } }.freeze

  def action_select
    intro
    loop do
      show_menu
      user_input = gets.chomp
      break if user_input == '0'

      if !MAINMENU.select { |key| key == user_input }.empty?
        begin
          run_action(MAINMENU[user_input])
        rescue StandardError => e
          exeption_hadler(e)
        end
      else
        puts @texts.wrong_input
      end
    end
  end

  def show_menu
    puts ''
    MAINMENU.each { |key, value| puts "  For #{value['text']} enter - #{key}" }
    puts '  For EXIT enter - 0'
    puts ''
  end

  def run_action(hash)
    if hash['method'].nil?
      send(hash['action'])
    elsif !hash['action'].nil?
      send(hash['action']).send(hash['method'])
    else
      send(hash['group']).send(hash['method'])
    end
  end

  def intro
    puts ''
    puts @texts.welcome_text
    puts ''
  end
end
