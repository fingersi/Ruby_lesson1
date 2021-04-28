# frozen_string_literal: true

class Train
  extend Manufacturer::ClassMethods
  include Manufacturer::InstanceMethods
  include ExceptionHadler
  extend ExceptionHadler
  extend InstanceCounter::ClassMethods
  include InstanceCounter::InstanceMethods
  extend Accessors
  extend Validation::ClassMethods
  include Validation::InstanceMethods

  TRAIN_NUMBER_FORMAT = /^[а-я0-9]{3}([( )|-])?[а-я0-9]{2}$/i.freeze
  TRAIN_CARS_FORMAT = /^[0-9]{1,3}$/.freeze

  attr_accessor :number, :speed, :train_cars
  attr_reader :type, :type_id, :route

  attr_accessor_with_history :current_station

  @@trains = []

  def initialize(number)
    @speed = 0
    @number = number
    @train_cars = []
    self.class.add_train(self)
    register_instance
    self.class.valid?(number)
    validate!
  end

  def self.add_train(train)
    @@trains << train
  end

  def self.trains
    @@trains
  end

  def self.valid?(number)
    valid!(number)
    true
  rescue StandardError => e
    exeption_hadler(e)
    false
  end

  def self.valid_train_cars?(value)
    valid_train_cars!(value)
    true
  rescue StandardError => e
    exeption_hadler(e)
    false
  end

  def self.valid!(number)
    raise StandardError, 'Input something, bitch.' if number.nil?

    raise StandardError, 'Train number should have 3 russian letters or digits - and 2 letters or digits ' if
     number !~ TRAIN_NUMBER_FORMAT
  end

  def self.valid_train_cars!(value)
    int_value = value.to_i
    raise StandardError, 'Input something, bitch' if value.nil?
    raise StandardError, 'Number of train cars should greater that 1 and less 100' if int_value < 1 || int_value > 100
    raise StandardError, 'You can enter all digits' if value !~ TRAIN_CARS_FORMAT
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
    # raise ArgumentError, 'Argument is not a TrainCar' if self.class.validate train_car, :type, :TrainCar

    raise StandardError, 'Cannot add train car. Wrong train car type or train has speed.' unless
     @type == train_car.type && @speed.zero?

    @train_cars << train_car
    puts "train_car #{train_car} "
  end

  def delete_train_car
    raise StandardError, 'Stop train before deleting train cars' unless @speed.zero?

    @train_cars.slice(-1, 1) if @train_cars.size.positive?
    puts "Train car has been deleted.train_cars_number: #{@train_cars.size}"
  end

  def add_route(route)
    puts "route.instance_of? Route #{route.instance_of? Route}"
    raise ArgumentError, 'Argument is not a Route' unless route.instance_of? Route

    @route = route
    change_station(route.departure_station)
    puts "Train has moved to #{current_station&.name}"
  end

  def next_station
    raise StandardError, 'Train has no route' if @route.nil?

    route_stations = @route.stations
    st_index = route_stations.index(current_station)
    st_index == route_stations.size ? (return nil) : @route.stations[st_index + 1]
  end

  def prev_station
    raise StandardError, 'Train has no route' if @route.nil?

    route_stations = @route.stations
    st_index = route_stations.index(current_station)
    st_index.zero? ? (return nil) : (route_stations[st_index - 1])
  end

  def change_station(station)
    puts "before current_station #{current_station}"
    current_station&.train_departure(self)
    station.train_arrive(self)
    self.current_station = station
    station
  end
end
