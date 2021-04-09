# Class for basic user inputs.
class UserInput
  attr_accessor :station_int, :route_int, :train_int

  def initialize(main, texts)
    @main = main
    @texts = texts
  end

  def show_all_input
    loop do
      puts @texts.display_select
      user_input = gets.chomp
      return if user_input == 'stop'
      return user_input if %w[1 2 3].include?(user_input)

      puts @texts.wrong_input
    end
  end

  def select_action(text)
    loop do
      puts text
      user_input = gets.chomp
      return if user_input == 'stop'
      return user_input if %w[1 2].include?(user_input)

      puts @texts.wrong_input
    end
  end

  def bloct_it_input
    puts @texts.choise_block_it
    user_input = gets.chomp.to_i
    raise StationError, 'Wrong input' if user_input != 1 || user_input != 2
  end
end
