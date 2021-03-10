# User Interface methodes
class UserInterface < Main
  include ExceptionHadler

  def create_train
    train_number = @user_input_train.enter_train_number
    train_type = @user_input_train.select_action(@texts.select_train_type)

    case train_type
    when '1'
      puts 'before train creation'
      tr = CargoTrain.new(train_number)
      @train_int.create_train_cars_for_train(tr)
    when '2'
      @train_int.create_train_cars_for_train(PassengerTrain.new(train_number))
    end
  end

  def show_all_input
    case @user_input.show_all_input
    when '1'
      @station_int.show_all_stations
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
    train.nil? || route.nil? ? (puts @texts.cannot_add_route) : train.add_route(route)
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
    train.manufacturer = @user_input_train.enter_manufacturer
  end

  def train_find
    train = Train.find(@user_input_train.find_train)
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
    case @user_input.select_action(@texts.choise_block_it)
    when '1'
      @middleware.block_it(@station_int.select_station)
    when '2'
      @middleware.block_it(@train_int.select_train)
    end
  end

  def show_train
    @train_int.show_train(@train_int.select_train)
  end

  def add_load_input
    train = @train_int.select_train
    @train_int.show_train_cars(train)
    train_car = @train_int.select_train_car(train)
    @train_car_int.add_load(@user_input_train.add_load, train_car)
  end

  def create_route
    Route.enough_stations
    puts @texts.add_route
    depature_station = @user_input_route.select_departure_station
    arrival_station = @user_input_route.select_arrival_station(depature_station)
    @route_int.create_route(depature_station, arrival_station)
  end
end
