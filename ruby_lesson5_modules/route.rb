require_relative 'instancecounter'

class Route
  attr_reader :departure_station, :arrival_station
  attr_accessor :way_stations

  extend InstanceCounter::ClassMethods
  include InstanceCounter::InstanceMethods

  @@routes = []
  def initialize(departure_station, arrival_station)
    @departure_station = departure_station
    @arrival_station = arrival_station
    @way_stations = []
    @@routes << self
    register_instance
  end

  # метод публичный, используется в интерфейсе
  def self.show_all_routes
    index = 0 
    if @@routes.any?
      @@routes.each do |route| 
        puts "index: #{index} route from #{route.departure_station.name}, to #{route.arrival_station.name}"
        index += 1
      end
    else
      puts Texts.no_routes
    end
  end

  # Публичный, потому что использовается в интерфейсе пользователя
  def show_way_stations
    index = 0
    self.way_stations.each do |station|
      puts "index: #{index}, station name #{station.name}"
      index += 1
    end
  end

  # Публичный, потому что использовается в интерфейсе пользователя
  def self.routes
    @@routes
  end

  # Публичный,  использовается в интерфейсе пользователя.
  def add_station(station)
    @way_stations << station
  end

  # Публичный,  использовается в интерфейсе пользователя.
  def delete_station(station)
    puts 'You cannot delete departure station' if station == @departure_station
    puts 'You cannot delete arrival station' if station == @arrival_station
    @way_stations.delete(station) 
  end

  # Публичный,  использовается в интерфейсе пользователя.
  def show_stations
    index = 0
    self.stations.each do |station|
      puts "index #{index}, Station name #{station.name} "
      puts station.name
    end
  end

  # Публичный,  использовается в классе Train
  def stations
    [@departure_station, @way_stations, @arrival_station].flatten
  end

  # Публичный,  использовается в интерфейсе пользователя.
  def delete_way_station(station)
    @way_stations.delete(station)
  end
end