class RouteInterface

  def initialize(texts)
    @texts = texts
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
    index = 0
    route.way_stations.each do |station|
      puts "index: #{index}, station name #{station.name}"
      index += 1
    end
  end

  def create_route(departure_station_index, arrival_station_index)
    route = Route.new(Station.stations[departure_station_index], Station.stations[arrival_station_index])
    user_input_way_stations(route)
  end

  def select_route
    show_all_routes
    @user_input.create_route
  end

  def delete_station_route(route)
    loop do
      show_way_stations(route)
      user_input = gets.chomp
      if user_input == 'stop'
        break
      elsif !user_input.to_i.nil?
        route.delete_station(route.way_stations[user_input.to_i])
      else
        puts @texts.wrong_input
      end
    end
  end

  def add_stations_route(route)
    loop do
      stations = available_to_adding(route)
      stations_show(stations)
      puts @texts.select_station_for_route
      user_input = gets.chomp
      if user_input == 'stop'
        break
      elsif Route.valid_station!(Station.find_by_name(stations[user_input.to_i]))
        break 
      elsif !user_input.nil?
        route.add_station(Station.find_by_name(stations[user_input.to_i]))
      else
        puts @texts.wrong_input
      end
    end
  end

  def stations_show(hash)
    if !hash.nil?
      hash.each { |key, value| puts "key #{key} value #{value}"}
    else
      puts 'No station to adding'
    end
  end

  def available_to_adding(route)
    route_stations = route.stations
    stations = {}
    i = 0
    Station.stations.each do |station|
      unless route_stations.detect {|st| st.name == station.name }
        stations[i] = station.name
        i += 1
      end
    end
    stations
  end

  def user_input_way_stations(route)
    loop do
      puts @texts.add_way_stations
      user_answer = gets.chomp.to_i
      case user_answer
      when 0
        break
      when 1
        add_stations_route(route)
        break
      else
        puts @texts.wrong_input
      end
    end
  end

  def route_edit
    loop do
      puts @texts.route_edit
      user_input = gets.chomp.to_i
      case user_input
      when  0
        break
      when  1
        add_stations_route(select_route)
        break
      when  2
        delete_station_route(select_route)
        break
      else
        puts @texts.wrong_input
      end
    end
  end

  def show_stations
    self.stations.each_with_index do |station, index|
      puts "index #{index}, Station name #{station.name} "
      puts station.name
    end
  end

end