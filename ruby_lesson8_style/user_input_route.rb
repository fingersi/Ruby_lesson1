# All user inputs for Route class.
class UserInputRoute < UserInput
  include ExceptionHadler

  def initialize(main, texts = Texts.new)
    super(main, texts)
  end

  def delete_station_route(route)
    loop do
      user_input = gets.chomp
      return if user_input == 'stop'
      return route.delete_station(route.way_stations[user_input.to_i]) unless route.way_stations[user_input.to_i].nil?

      puts @texts.wrong_input
    end
  end

  def add_stations_route(stations)
    loop do
      puts @texts.select_station_for_route
      user_input = gets.chomp
      return if user_input == 'stop'

      station_name = stations[user_input.to_i]
      return if Route.valid_station!(Station.find_by_name(station_name))
      return station_name unless station_name.nil?

      puts @texts.wrong_input
    end
  end

  def select_action(text)
    puts text
    user_input = gets.chomp
    return if user_input == 'stop'
    return user_input if %w[1 2].include?(user_input)

    puts @texts.wrong_input
  end

  def select_departure_station
    loop do
      @main.station_int.show_all_stations
      puts @texts.choose_departure_station
      departure_station_index = gets.chomp.to_i
      return departure_station_index if Route.index_valid?(departure_station_index)

      puts @texts.wrong_input
    end
  end

  def select_arrival_station(departure_station_index)
    loop do
      puts @texts.choose_arrival_station
      arrival_station_index = gets.chomp.to_i
      if Route.index_valid?(arrival_station_index) && departure_station_index != arrival_station_index
        return arrival_station_index
      end

      puts @texts.wrong_input
    end
  end

  def select_route
    loop do
      puts @texts.select_route_for_editing
      user_input = gets.chomp
      raise StandardError, 'User stops input' if user_input == 'stop'

      return user_input.to_i unless Route.routes[user_input.to_i].nil?

      puts @texts.wrong_input
    end
  end
end
