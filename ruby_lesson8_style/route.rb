require_relative 'instancecounter'

class Route
  attr_reader :departure_station, :arrival_station
  attr_accessor :way_stations

  extend InstanceCounter::ClassMethods
  include InstanceCounter::InstanceMethods

  @@routes = []

  def initialize(departure_station, arrival_station)
    self.class.valid_station!(arrival_station)
    self.class.valid_station!(departure_station)
    @departure_station = departure_station
    @arrival_station = arrival_station
    @way_stations = []
    @@routes << self
    register_instance
  end

  def self.valid_station?(station)
    self.valid_station!(station)
    true
    rescue StandardError => e
      e
  end

  def self.index_valid?(index)
    index_valid!(index)
    true
  rescue StandardError => e
    e
  end

  def self.index_valid!(index)
    raise StandardError, "Wrong station index." if Station.stations[index].nil?
  end

  def self.routes
    @@routes
  end

  def self.valid_station!(station)
    puts "station: #{station}"
    raise StandardError, 'Objects is not a Station' unless station.kind_of?(Station)
  end

  def self.enough_stations
    raise StandartError, 'You need two stations if you want create a route' if Station.stations.size < 2 
  end

  def add_station(station)
    self.class.valid_station!(station)
    @way_stations << station
  end

  def delete_station(station) 
    raise StandardError, 'You cannot delete departure station' if station == @departure_station
    raise StandardError, 'You cannot delete arrival station' if station == @arrival_station
    @way_stations.delete(station) 
  end

  def stations
    [@departure_station, @way_stations, @arrival_station].flatten
  end

  def delete_way_station(station)
    @way_stations.delete(station)
  end

  private

  def stations_show(hash)
    if !hash.nil?
      hash.each{|key, value| puts"key #{key} value #{value}"}
    else
      puts 'No station to adding' 
    end
  end


end