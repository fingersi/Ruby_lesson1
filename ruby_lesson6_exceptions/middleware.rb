class MiddleWare

  WAY_STATION_FORMAT = /^\d*$/ 

  def initialize(texts)
    @texts = texts
  end

# Публичный, используется только внутри интерфейса
  def select_route
    Route.show_all_routes
    loop do
      puts @texts.select_route_for_editing
      user_input = gets.chomp
      if user_input =='stop'
        break
      elsif !user_input.nil?
        return Route.routes[user_input.to_i]
      else
        puts @texts.wrong_input
      end
    end
  end 

  # Не публичный, используется только внутри интерфейса
  def select_station
    loop do
      Station.show_all_stations
      puts @texts.select_station
      user_input = gets.chomp
      return nil if !Train.trains.any?
      if user_input == 'stop'
        break
      elsif !user_input.to_i.nil?
        return Station.all[user_input.to_i]
      else
        puts @texts.wrong_input
      end
    end
  end

   # Публичный, используется внутри интерфейса
  def delete_station_route(route)
    loop do
      route.show_way_stations
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

# Публичный, используется внутри интерфейса
  def add_stations_route(route)
    loop do
      stations = available_to_adding(route)
      stations_show(stations)
      puts @texts.select_station_for_route
      user_input = gets.chomp
      if user_input == 'stop'
        break
      elsif !Route.station_valid?(stations)
        break 
      elsif !user_input.nil?
        route.add_station(Station.find_by_name(stations[user_input.to_i]))
      else
        puts @texts.wrong_input
      end
    end
  end

  # Публичный, используется внутри интерфейса
  def route_station_select
    loop do
      Station.show_all_stations
      puts @texts.choose_departure_station
      departure_station_index = gets.chomp.to_i
      return nil until Route.index_valid?(departure_station_index)
      
      puts @texts.choose_arrival_station
      arrival_station_index = gets.chomp.to_i
      return nil until Route.index_valid?(arrival_station_index)

      if departure_station_index == arrival_station_index
        (puts @texts.wrong_input)
        return nil
      else
        (return [departure_station_index, arrival_station_index])
      end
    end
  end

  # Не публичный, используется только внутри интерфейса
  def select_train
    loop do
      Train.show_all_trains
      if Train.trains.empty?
        return nil
      end
      puts @texts.select_train
      user_input = gets.chomp
      return nil if Train.trains.empty?
      
      if user_input == 'stop'
        break
      elsif !user_input.to_i.nil? && !Train.trains[user_input.to_i].nil?
        return Train.trains[user_input.to_i]
      else
        puts @texts.wrong_input
      end
    end
  end

  private

# Не публичный, используется только внутри middleware
  def stations_show(hash)
    if !hash.nil?
      hash.each{|key, value| puts"key #{key} value #{value}"}
    else
      puts 'No station to adding' 
    end
  end

# Не публичный, используется только внутри middleware
  def available_to_adding(route)
    route_stations = route.stations
    stations = {}
    i = 0
    Station.all.each do |station|
      if !route_stations.detect {|st| st.name == station.name }
        stations[i] = station.name
        i += 1
      end
    end
    return stations
  end

end