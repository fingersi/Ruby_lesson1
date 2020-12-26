class UserInterface

  def initialize(texts)
    @texts = texts
    @middleware = MiddleWare.new(texts)
  end

# Основной метод в классе, поэтому публичный вызывает все остальные.
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
        create_station
      when '3'
        create_route
      when '4'
        create_train
      when '5'
        route_edit
      when '6'
        trains_on_station
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

 protected

 #Не публичный, запускается из 
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

#Не публичный, используется только внутри интерфейса
  def create_station
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

#Не публичный, используется только внутри интерфейса
  def create_route
    puts @texts.add_route
    if Station.method_defined?(:stations) && Station.stations.size >= 1
      puts @texts.you_need_2_stations
    end
    stations_index = @middleware.route_station_select
    route = Route.new(Station.stations[stations_index[0]], Station.stations[stations_index[1]])
    user_input_way_stations(route)
  end

#Не публичный, используется только внутри интерфейса
  def user_input_way_stations(route)
    loop do
      puts @texts.add_way_stations
      user_answer = gets.chomp.to_i
      case user_answer
      when 0
        break
      when 1
        @middleware.add_stations_route(route)
        break
      else
        puts @texts.wrong_input
      end
    end
  end

# Не публичный, используется только внутри интерфейса
  def route_edit
    loop do
      puts @texts.route_edit
      user_input = gets.chomp.to_i
      case user_input
      when  0
        break
      when  1
        @middleware.add_stations_route(@middleware.select_route)
        break
      when  2
        @middleware.delete_station_route(@middleware.select_route)
        break
      else
        puts @texts.wrong_input
      end
    end
  end

# Не публичный, используется только внутри интерфейса
  def create_train
    loop do
      puts @texts.create_train_name
      train_name = gets.chomp
      puts @texts.select_train_type
      train_type = gets.chomp
      case train_type
      when '1'
        user_input_train_cars(CargoTrain.new(train_name))
        break
      when '2'
        user_input_train_cars(PassengerTrain.new(train_name))
        break
      else
        puts @texts.wrong_input
      end
    end
  end

# Не публичный, используется только внутри интерфейса
  def user_input_train_cars(train)
    loop do
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

# Не публичный, используется только внутри интерфейса
  def train_move
    loop do
      puts @texts.train_move_direction
      user_input = gets.chomp
      case user_input
      when '1'
        train = @middleware.select_train
        train.route.nil? ? (puts @texts.train_no_route) : 
        (train.move_forward)
      when '2'
        train = @middleware.select_train
        train.route.nil? ? (puts @texts.train_no_route) : 
        (train.move_backward)
      when 'stop'
        break
      else
        @texts.wrong_input
      end
    end
  end

# Не публичный, используется только внутри интерфейса
  def train_add_route
    train = @middleware.select_train
    route = @middleware.select_route
    train.nil? || route.nil? ? (puts @texts.cannot_add_route) : (train.add_route(route))
  end

# Не публичный, используется только внутри интерфейса
  def add_delete_train_car
    train = @middleware.select_train
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

# Не публичный, используется только внутри интерфейса
  def trains_on_station
    station = @middleware.select_station
    station.list_trains
  end

end