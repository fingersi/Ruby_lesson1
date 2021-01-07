require_relative 'manufacturer'
require_relative 'instancecounter'

class Train
  attr_accessor :number, :speed, :train_cars
  
  @@trains = []

  include Manufacturer
  extend InstanceCounter::ClassMethods
  include InstanceCounter::InstanceMethods
  
  self.class_init

  attr_reader :type, :current_station, :type_id, :route
 
  def initialize(number)
    @speed = 0
    @number = number
    @train_cars = []
    @@trains << self
    register_instance
  end

  def self.show_all_trains
    if @@trains.any?
      index = 0
      @@trains.each do |train| 
        puts "index: #{index}, train number: #{train.number}, type: #{
        train.class}, current station: #{
        train.current_station}, route: #{train.route},  manufacturer: #{train.manufacturer}"
        index += 1
      end
    else
      puts Texts.no_train
    end
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

  def add_train_car(train_car)
    puts 'I am in Train.add_train_car'
    if self.type == train_car.type && @speed == 0
      @train_cars << train_car
      puts "train_car #{train_car} "
    else 
      puts 'Cannot add train car. Please, check train car type or stop the train.'
    end
  end
  
  def show_train_cars_number
    puts "train_cars_number: #{train_cars_number}"
  end

  def delete_train_car
    if @speed == 0
      @train_cars_number -= 1 if @train_cars_number > 0
      puts "Train car has been deleted. 
      train_cars_number: #{@train_cars_number}"
    else
     puts "Stop train before deleting train cars "
    end
  end
  
  def add_route(route)
    @route = route
    self.change_station(route.departure_station)
    puts "Train has moved to #{@current_station.name}"
  end

  def move_forward
    next_station = self.next_station
    if next_station.nil?
      puts 'Train is on last station on the route. Please add new route.'
    else
      self.change_station(next_station)
      puts "Train has moved to station: #{@current_station.name}"
    end
  end

  def move_backward
    prev_station = self.prev_station
    if prev_station.nil?
      puts 'Train is at departion station on the route. You can only move train forward.'
    else
      self.change_station(prev_station)
      puts "Train has moved to station: #{@current_station.name}."
    end
  end

  def show_next_station
    if @current_station.nil?
      puts 'Trains has no route.'
    else
      next_station = self.next_station
      if next_station.nil?
       puts 'Train is on last station on the route. Please add new route.'
      else 
        puts "Train's next station is #{@route[st_index + 1]}"
      end 
    end
  end

  def show_prev_station
    if @current_station.nil?
      puts 'Trains has no route.'
    else
     self.prev_station.nil? ? (puts 'Train is on departure station on the route.') : 
     (puts "Train's previous station is #{@route[st_index - 1]}")
    end
  end

  def show_current_station
    @current_staion.nil? ? (puts "Train is in nowhere =)") : (puts "Train's current station is: #{@current_station.name}")
  end

  def show_stations_on_route
    if @current_station.nil?
      puts 'Trains has no route.'
    else
      self.stations_on_route.each{ |station| puts station.name if !station.nil?}
    end
  end

  def next_station
    return nil if @route.nil?

    route_stations = @route.stations
    st_index = route_stations.index(@current_station)
    st_index == route_stations.size ? (return nil) : ( @route.stations[st_index + 1] )
  end

  def prev_station
    route_stations = @route.stations
    st_index = route_stations.index(@current_station)
    st_index == 0 ? (return nil) : ( route_stations[st_index - 1] )  
  end

  def stations_on_route
    index = 0
    route_staions = @route.stations
    route_staions.each do |station| 
    if station == @current_station
      prev_st = route_staions[index - 1]
      next_st = route_staions[index + 1]
      return [prev_st, @current_station, next_st]
    end
      index += 1
    end
  end

  def change_station(station)
    @current_station.train_departure(self) if !@current_station.nil?
    station.train_arrive(self)
    @current_station = station
    return station
  end

  def add_train_cars(number, manufacturer)
    if type == 'cargo'
      number.times do
        train_car = CargoTrainCar.new
        train_car.manufacturer = manufacturer 
        self.train_cars << train_car
      end
    else
      number.times do
        train_car = PassengerTrainCar.new
        train_car.manufacturer = manufacturer
        self.train_cars << train_car
      end
    end
    puts "Train #{@number} has #{@train_cars.size} train cars"
  end

  def delete_train_cars(number)
    if type == 'cargo'
      number.times { train_cars.slice!(-1, 1)} 
    else
      number.times { train_cars.slice!(-1, 1)} 
    end
    puts "#{number} trains cars has been deleted. Now train #{@number} has #{@train_cars.size}"
  end
end