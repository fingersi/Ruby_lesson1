require_relative 'exceptionhadler'

class UserInterface

  include ExceptionHadler

  def initialize(texts, station_int, route_int, train_int, user_input)
    @texts = texts
    @train_int = train_int
    @route_int = route_int
    @station_int = station_int
    @middleware = MiddleWare.new(texts)
    @user_input = user_input
  end

  def create_train
    train_number = @user_input.enter_train_number
    train_type = @user_input.select_action(@texts.select_train_type)

    case train_type
    when '1'
      @train_int.create_train_cars_for_train(CargoTrain.new(train_number))
    when '2'
      @train_int.create_train_cars_for_train(PassengerTrain.new(train_number))
    end
  end

  def show_all_input
    case @user_input.show_all_input
    when '1'
      @station_ClassNameint.show_all_stations
    when '2'
      @route_int.show_all_routes
    when '3'
      @train_int.show_all_trains_with_cars
    end
  end

  def user_input_train_cars(train)
    hash = @user_input.user_input_train_cars
    @train_int.add_train_cars(train, hash)
  end

  def train_direction_select
    train = @train_int.select_train
    raise StandardError, 'Train has no route' if train.route.nil?

    case @user_input.select_action(@texts.train_move_direction)
    when '1'
      @train_int.move_forward(train)
    when '2'
      @train_int.move_backward(train)
    end
  end

  def train_add_route
    train = @train_int.select_train
    route = @route_int.select_route
    train.nil? || route.nil? ? (puts @texts.cannot_add_route) : (train.add_route(route))
  end

  def add_delete_train_car
    train = @train_int.select_train
    case @user_input.select_action(@texts.add_delete_train_car)
    when '1'
      user_input_train_cars(train)
    when '2'
      @train_int.delete_train_cars(train, 1)
    end
  end

  def trains_on_station
    @station_int.show_station_trains(@station_int.select_station)
  end

  def train_add_manufacturer
    train = @train_int.select_train
    if train.nil?
      puts @texts.no_train
      return nil
    end
    train.manufacturer = @user_input.enter_manufacturer
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
      case bloct_it_input
      when '1'
        @middleware.block_it(@station_int.select_station)
      when '2'
        @middleware.block_it(@train_int.select_train)
      when 'stop'
        break
      end
    end
  end

  def bloct_it_input
    puts @texts.choise_block_it
    user_input = gets.chomp.to_i
    raise StationError, 'Wrong input' if user_input != 1 || user_input != 2
  end

  def show_train
    @train_int.show_train(@train_int.select_train)
  end

  def add_load_input
    train = @train_int.select_train
    @train_int.show_train_cars(train)
    train_car = @train_int.select_train_car(train)
    loop do
      puts @texts.add_load
      user_input_load = gets.chomp
      break if train_car.valid_load!(user_input_load)
    end
    add_load(user_input_load.to_i, train_car)
  end

  def add_load(load, train_car)
    if train.train_cars[load].type == 'Cargo'
      train_car.add_load(load)
    else
      load.times { train.train_cars[load].add_load }
    end
  end

  def create_route
    Route.enough_stations
    puts @texts.add_route
    depature_station = @user_input.select_departure_station
    arrival_station = @user_input.select_arrival_station(depature_station)
    @route_int.create_route(depature_station, arrival_station)
  end
end
