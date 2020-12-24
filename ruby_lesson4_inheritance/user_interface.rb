class UserInterface
  def initialize(texts)
    @texts = texts
  end
  def action_select
    loop do
      puts @texts.select_action
      input = gets.chomp
      case input
      when '0'
        break
      when '1'
        display_input
      when '2'
        station_input
      when '3'
        route_input
      when '4'
        train_input
      when '5'
        route_edit
      when '6'
        train_input
      when '7'
        train_move
      when '8'
        add_delete_train_car
      when '9'
        train_add_route
      else
        puts @texts.select_action_wrong_input
      end
    end
  end

  def display_input
    puts @texts.display_select
    user_input = gets.chomp.to_i
    case user_input.to_i
    when user_input.nil?
      puts @texts.wrong_input
      return
    when 1
      Station.show_all_stations
    when 2
      Route.show_all_routes
    when 3
      Train.show_all_trains
    else
      @texts.wrong_input
    end
  end

  def station_input
    loop do
      puts @texts.add_station
      station_name = gets.chomp
      if !station_name.nil?
        Station.new(station_name)
        Station.show_all_stations
        break
      else
        puts @texts.wrong_input
      end
    end
  end

  def route_input
    puts @texts.add_route
    if Station.method_defined?(:stations) && Station.stations.size >= 1
      puts @texts.you_need_2_stations
    end
    stations_index = station_select
    route = Route.new(Station.stations[stations_index[0]], Station.stations[stations_index[1]])
    user_input_way_stations(route)
  end

  def user_input_way_stations(route)
    loop do
      puts @texts.add_way_stations
      user_answer = gets.chomp.to_i
      case user_answer
      when 0
        break
      when 1
        choose_for_add_stations(route)
        break
      else
        puts @texts.wrong_input
      end
    end
  end

  def choose_for_add_stations(route)
    loop do
      memo = available_to_adding(route)
      stations_show(memo)
      puts 'Enter station index, for stop enter stop'
      user_input = gets.chomp
      if user_input == 'stop'
        break
      elsif !user_input.nil?
        route.add_station(Station.find_by_name(memo[user_input.to_i]))
      else
        puts @texts.wrong_input
      end
    end
  end
  
  def stations_show(hash)
    if !hash.nil?
     hash.each{|key, value| puts"key #{key} value #{value}"}
    else
      puts 'No station to adding' 
    end
  end

  def available_to_adding(route)
    route_stations = route.stations
    puts "route_stations: #{route_stations}"
    stations = {}
    i = 0
    Station.stations.each do |station|
      puts "Station.name #{station.name}"
      if !route_stations.detect {|st| st.name == station.name }
        stations[i] = station.name
        i += 1
      end
    end
    return stations
  end

  def station_select
    loop do
      Station.show_all_stations
      puts @texts.choose_departure_station
      departure_station_index = gets.chomp.to_i
      puts @texts.choose_arrival_station
      arrival_station_index = gets.chomp.to_i
      departure_station_index == arrival_station_index ? (puts @text.wrong_input) :
        (return [departure_station_index, arrival_station_index])
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
        choose_for_add_stations(select_route)
        break
      when  2
        delete_station(select_route)
        break
      else
        puts @texts.wrong_input
      end
    end
  end

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

  def delete_station(route)
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

  def train_input
    loop do
      puts @texts.add_train
      train_name = gets.chomp
      puts @texts.choose_train_type
      train_type = gets.chomp.to_i
      if train_type == 0
        user_input_train_cars(CargoTrain.new(train_name))
        break
      elsif train_type == 1
        user_input_train_cars(PassengerTrain.new(train_name))
        break
      else
        puts @texts.wrong_input
      end
    end
  end

  def user_input_train_cars(train)
    loop do
      puts 'I am in add_train_cars_for_train'
      puts @texts.add_train_cars
      user_input = gets.chomp.to_i
      if user_input.nil?
        puts @texts.wrong_input
      else
        train.add_train_cars(user_input)
        break
      end
    end
  end

  def train_move
    loop do
      puts @texts.train_move_direction
      user_input = gets.chomp
      case user_input
      when '1'
        puts ' train move selected 1'
        train = select_train
        train.route.nil? ? (puts @texts.train_no_route) : 
        (train.move_forward)
      when '2'
        puts ' train move selected 1'
        train = select_train
        train.route.nil? ? (puts @texts.train_no_route) : 
        (train.move_backward)
      when 'stop'
        break
      else
        @texts.wrong_input
      end
    end
  end



  def select_train
    loop do
      Train.show_all_trains
      puts @texts.select_train
      user_input = gets.chomp
      return nil if !Train.trains.any?
      if user_input == 'stop'
        break
      elsif !user_input.to_i.nil?
        return Train.trains[user_input.to_i]
      else
        puts @texts.wrong_input
      end
    end
  end

  def train_add_route
    train = select_train
    route = select_route
    train.nil? || route.nil? ? (puts @texts.cannot_add_route) : (train.add_route(route))
  end

  def add_delete_train_car
    train = select_train
    loop do
      puts @texts.add_delete_train_car
      user_input = gets.chomp
      case user_input
      when '1'
        train.add_train_cars(1)
      when '2'
        train.delete_train_cars(1)
      when 'stop'
        break
      else
        puts @texts.wrong_input
      end
    end
  end

end