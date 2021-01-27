require_relative 'exceptionhadler'

class UserInterface

  include ExceptionHadler

  
  def initialize(texts, station_int, route_int, train_int )
    @texts = texts
    @train_int = train_int
    @route_int = route_int
    @station_int = station_int
    @middleware = MiddleWare.new(texts)
  end
=begin
  def self.train_int
    @train_int
  end

  def self.route_int
    @route_int
  end

  def self.train_int
    @train_int
  end
=end
  def show_all_input
    puts @texts.display_select
    user_input = gets.chomp.to_i
    case user_input.to_i
    when user_input.nil?
      puts @texts.wrong_input
      return
    when 1
      @station_int.show_all_stations
    when 2
      @route_int.show_all_routes
    when 3
      @train_int.show_all_trains_with_cars
    else
      @texts.wrong_input
    end
  end

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
        @train_int.add_train_cars(train, user_input_size.to_i, user_input_loaded.to_i, user_input_manufacturer, user_input_number.to_i )
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
        train = @train_int.select_train
        train.route.nil? ? (puts @texts.train_no_route) : 
        (@train_int.move_forward(train))
      when '2'
        train = @train_int.select_train
        train.route.nil? ? (puts @texts.train_no_route) : 
        (@train_int.move_backward(train))
      when 'stop'
        break
      else
        @texts.wrong_input
      end
    end
  end

  def train_add_route
    train = @train_int.select_train
    route = @route_int.select_route
    train.nil? || route.nil? ? (puts @texts.cannot_add_route) : (train.add_route(route))
  end

  def add_delete_train_car
    train = @train_int.select_train
    loop do
      puts @texts.add_delete_train_car
      user_input = gets.chomp
      case user_input
      when '1'
        user_input_train_cars(train)
        #puts @texts.manufacturer
        #user_input_manufacturer = gets.chomp
        #@train_int.add_train_cars(train, 1, user_input_manufacturer)
      when '2'
        @train_int.delete_train_cars(train, 1)
      when 'stop'
        break
      else
        puts @texts.wrong_input
      end
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
        @middleware.block_it(@station_int.select_station)
      when "2"
        @middleware.block_it(@train_int.select_train)
      when "stop"
        break
      end
    end
  end

  def show_train
    @train_int.show_train(@train_int.select_train)
  end

  def add_load
    train = @train_int.select_train
    @train_int.show_train_cars(train)
    loop do
      puts @texts.select_train_car
      user_input_train_index = gets.chomp
      if user_input_train_index.to_i <= train.train_cars.size
        puts @texts.add_load
        user_input_load = gets.chomp.to_i
        if train.train_cars[user_input_train_index.to_i].type == "Cargo"
          train.train_cars[user_input_train_index.to_i].add_load(user_input_load.to_i)
        else
          user_input_load.to_i.times { train.train_cars[user_input_train_index.to_i].add_load }
        end
        break
      else
        puts @texts.wrong_input
      end
    end
  end

end