require_relative 'exceptionhadler'

class UserInterface

  include ExceptionHadler

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
      show_all_input
      when '2'
        create_station
      when '3'
        create_route
      when '4'
        begin
          create_train
        rescue StandardError => e
          exeption_hadler(e)
        end

      when '5'
        begin
          route_edit
        rescue StandardError => e
          exeption_hadler(e)
        end
      when '6'
        begin
          trains_on_station
        rescue StandardError => e
          exeption_hadler(e)
        end
      when '7'
        begin
          train_move
        rescue StandardError => e
          exeption_hadler(e)
        end
      when '8'
        begin
          add_delete_train_car
        rescue StandardError => e
          exeption_hadler(e)
        end
      when '9'
        begin
          train_add_route
        rescue StandardError => e
          exeption_hadler(e)
        end
      when '10'
        begin
          train_add_manufacturer
        rescue StandardError => e
          exeption_hadler(e)
        end
      when '11'
        begin
          train_find
        rescue StandardError => e
          exeption_hadler(e)
        end
      when '12'
        begin 
          instances_number
        rescue StandardError => e
          exeption_hadler(e)
        end
      when '13'
        begin 
          block_it
        rescue StandardError => e
          exeption_hadler(e)
        end
      when '14'
        begin
          show_train
        rescue StandardError => e
          exeption_hadler(e)
        end
      when '15'
        begin
          add_load
        rescue StandardError => e
          exeption_hadler(e)
        end
      else
        puts @texts.wrong_input
      end
    end
  end

 private

 #Не публичный, запускается из 
  def show_all_input
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
      @middleware.show_all_trains_with_cars
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
        Station.show_all_stations if Station.new(station_name)
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
    return nil if stations_index.nil?
    route = Route.new(Station.all[stations_index[0]], Station.stations[stations_index[1]])
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
      puts @texts.create_train_number
      train_number = gets.chomp
      Train.valid!(train_number)
      puts @texts.select_train_type
      train_type = gets.chomp
      case train_type
      when '1'
        user_input_train_cars(CargoTrain.new(train_number))
        break
      when '2'
        user_input_train_cars(PassengerTrain.new(train_number))
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
      user_input_number = gets.chomp
      break if Train.valid_train_cars!(user_input_number)
      puts @texts.manufacturer
      user_input_manufacturer = gets.chomp
      puts @texts.enter_size
      user_input_size = gets.chomp
      puts @texts.enter_load
      user_input_loaded = gets.chomp
      return unless TrainCar.valid?(user_input_size, user_input_loaded)
    
      if user_input_number.nil?
        puts @texts.wrong_input
      else
        train.add_train_cars(user_input_size.to_i, user_input_loaded.to_i, user_input_manufacturer, user_input_number.to_i )
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
        #break unless 
        train.route.nil? ? (puts @texts.train_no_route) : 
        (train.move_forward)
      when '2'
        train = @middleware.select_train
        #break unless train.nil?
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
        puts @texts.manufacturer
        user_input_manufacturer = gets.chomp
        train.add_train_cars(1, user_input_manufacturer)
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

  def train_add_manufacturer
    train = @middleware.select_train
    if train.nil?
      puts @texts.no_train
      return nil
    end
    loop do
      puts @texts.add_manufacturer
      user_input = gets.chomp
      if user_input.nil?
        puts @texts.wrong_input
      else
        train.manufacturer= user_input
        break
      end
    end
  end

  def train_find
    puts @texts.train_find
    user_input = gets.chomp
    return if user_input.nil?
    train = Train.find(user_input)
    if train.nil?
      puts @texts.no_train_found
    else 
      puts "Train: #{train.number} Station: #{train.current_station}"
    end
  end

  def instances_number
    puts "CargoTrains: #{CargoTrain.instances}, passengerTrain: #{PassengerTrain.instances} "
    puts "Stations: #{Station.instances}, Routes: #{Route.instances}"
  end

  def block_it
    loop do
      puts @texts.choise_block_it
      user_input = gets.chomp
      case user_input
      when "1"
        @middleware.block_it(Station)
      when "2"
        @middleware.block_it(Train)
      when "stop"
        break
      end
    end
  end

  def show_train
    @middleware.show_train(@middleware.select_train)
  end

  def add_load
    train = @middleware.select_train
    @middleware.show_train_cars(train)
    loop do
      puts @texts.select_train_car
      user_input_train_index = gets.chomp
      if user_input_train_index.to_i <= train.train_cars.size
        puts @texts.add_load
        user_input_load = gets.chomp.to_i
        if train.train_cars[user_input_train_index.to_i].type == "Cargo"
          train.train_cars[user_input_train_index.to_i].add_load(user_input_load.to_i)
        else
          user_input_load.to_i.times { train.train_cars[user_input_train_index.to_i].take_seat }
        end
        break
      else
        puts @texts.wrong_input
      end
    end
  end

end