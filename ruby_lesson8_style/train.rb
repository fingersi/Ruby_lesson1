require_relative 'manufacturer'
require_relative 'instancecounter'
require_relative 'exceptionhadler'

class Train

  extend Manufacturer::ClassMethods
  include Manufacturer::InstanceMethods
  include ExceptionHadler
  extend InstanceCounter::ClassMethods
  include InstanceCounter::InstanceMethods

  TRAIN_NUMBER_FORMAT = /^[а-я0-9]{3}([( )|-])?[а-я0-9]{2}$/i
  TRAIN_CARS_FORMAT = /^[0-9]{1,3}$/
  
  @@trains = []

  attr_accessor :number, :speed, :train_cars
  attr_reader :type, :current_station, :type_id, :route
  
  def initialize(number)
    @speed = 0
    @number = number
    @train_cars = []
    @@trains << self
    register_instance
    self.class.valid?(number)
  end

  def self.valid?(number)
    valid!(number)
    true
  rescue StandardError => e
    e
  end

  def self.valid_train_cars?(value)
    valid_train_cars!(value)
    true
  rescue StandardError => e
    e
  end

  def self.valid!(number)
    raise StandardError, 'Input something, bitch.' if number.nil?
    raise StandardError, 'Train number should be have al least 3 letters.' if number.size < 5

    if (number !~ TRAIN_NUMBER_FORMAT)
      raise StandardError, 
      'Train number should have 3 russian letters or digits - and 2 letters or digits '
    end
  end

  def self.valid_train_cars!(value)
    int_value = value.to_i
    raise StandardError, 'Input something, bitch' if value.nil?
    raise StandardError, 'Number of train cars should greater that 1 and less 100' if int_value < 1 || int_value > 100
    raise StandardError, 'You can enter all digits' if value !~ TRAIN_CARS_FORMAT
  end

  def self.trains
    @@trains
  end

  def self.find(number)
    @@trains.detect { |train| train.number == number }
  end

  def stop
    @speed = 0
  end

  def block
    @train_cars
  end

  def add_train_car(train_car)
    if self.type == train_car.type && @speed == 0
      @train_cars << train_car
      puts "train_car #{train_car} "
    else
      raise StandardError, 'Cannot add train car. Wrong train car type or train has speed.'
    end
  end

  def delete_train_car
    if @speed == 0
      @train_cars_number -= 1 if @train_cars_number > 0
      puts "Train car has been deleted. 
      train_cars_number: #{@train_cars_number}"
    else
      raise StandardError, "Stop train before deleting train cars "
    end
  end

  def add_route(route)
    @route = route
    change_station(route.departure_station)
    puts "Train has moved to #{@current_station.name}"
  end

  def next_station
    raise StandardError, 'Train has no route' if @route.nil?

    route_stations = @route.stations
    st_index = route_stations.index(@current_station)
    st_index == route_stations.size ? (return nil) : ( @route.stations[st_index + 1] )
  end

  def prev_station
    raise StandardError, 'Train has no route' if @route.nil?

    route_stations = @route.stations
    st_index = route_stations.index(@current_station)
    st_index == 0 ? (return nil) : ( route_stations[st_index - 1] )  
  end

  def stations_on_route
    route_staions = @route.stations
    route_staions.each_with_index do |station, index|
      if station == @current_station
        prev_st = route_staions[index - 1]
        next_st = route_staions[index + 1]
        return [prev_st, @current_station, next_st]
      end
    end
  end

  def change_station(station)
    @current_station.train_departure(self) unless @current_station.nil?
    station.train_arrive(self)
    @current_station = station
    station
  end

end