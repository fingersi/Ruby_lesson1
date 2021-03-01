require_relative 'exceptionhadler'

class UserInputRoute
  include ExceptionHadler

  def initialize(texts)
    @texts = texts
  end

  def delete_station_route(route)
    loop do
      user_input = gets.chomp
      return if user_input == 'stop'
      return route.delete_station(route.way_stations[user_input.to_i]) if route.way_stations[user_input.to_i].nil?

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

      puts "I am shouldn't be here"
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

  def select_route
    puts @texts.select_route_for_editing
    user_input = gets.chomp
    raise StandartError, 'user stops input' if user_input == 'stop'

    return user_input.to_i if Route.routes[user_input.to_i].empty?
  end
end
