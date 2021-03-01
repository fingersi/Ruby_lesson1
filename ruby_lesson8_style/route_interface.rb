require_relative 'exceptionhadler'

class RouteInterface
  include ExceptionHadler

  def initialize(texts)
    @texts = texts
    @user_input_route = UserInputRoute.new(@texts)
  end

  def show_all_routes
    if Route.routes.any?
      Route.routes.each_with_index do |route, index| 
        puts "index: #{index} route from #{route.departure_station.name}, to #{route.arrival_station.name}"
      end
    else
      puts Texts.no_routes
    end
  end

  def show_way_stations(route)
    route.way_stations.each_with_index do |station, index|
      puts "index: #{index}, station name #{station.name}"
    end
  end

  def create_route(departure_station_index, arrival_station_index)
    route = Route.new(Station.stations[departure_station_index], Station.stations[arrival_station_index])
    user_input_way_stations(route)
  end

  def select_route
    show_all_routes
    Route.routes[@user_input_route.select_route]
  end

  def delete_station_route(route)
    show_way_stations(route)
    @user_input_route.delete_station_route
  end

  def add_stations_route(route)
    loop do
      stations = available_to_adding(route)
      stations_show(stations)
      station_name = @user_input_route.add_stations_route(stations)
      break if station_name.nil?

      route.add_station(Station.find_by_name(station_name))
    end
  end

  def stations_show(hash)
    if !hash.empty?
      hash.each { |key, value| puts "key #{key} value #{value}"}
    else
      puts 'No stations to adding'
    end
  end

  def available_to_adding(route)
    route_stations = route.stations
    stations = {}
    index = 0
    Station.stations.each do |station|
      unless route_stations.detect { |st| st.name == station.name }
        stations[index] = station.name
        index += 1
      end
    end
    stations
  end

  def user_input_way_stations(route)
    user_answer = @user_input_route.select_action(@texts.add_way_stations)
    case user_answer
    when '1'
      add_stations_route(route)
    end
  end

  def route_edit
    user_answer = @user_input_route.select_action(@texts.route_edit)
    case user_answer
    when  '1'
      add_stations_route(select_route)
    when  '2'
      delete_station_route(select_route)
    end
  end

  def show_stations(route)
    route.stations.each_with_index do |station, index|
      puts "index #{index}, Station name #{station.name} "
      puts station.name
    end
  end
end
