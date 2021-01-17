require_relative  'instancecounter'

class Station
  attr_reader :name

  STATION_NAME_FORMAT = /^[а-я0-9]*([( )|-])?[а-я0-9]*$/i

  extend InstanceCounter::ClassMethods
  include InstanceCounter::InstanceMethods

  @@stations = []
  
  def initialize(name)
    return until valid?(name)
    @name = name
    @trains = []
    @@stations << self
    register_instance
  end

  def valid?(name)
    valid!(name)
    true
  rescue StandardError => e
    e
  end

  # Публичный, использовается в интерфейсе пользователя.
  def self.stations
    @@stations
  end

  def self.all
    @@stations
  end

  # Публичный,  использовается в интерфейсе пользователя. Yt
  def self.find_by_name(station_name)
    @@stations.detect { |station| station.name == station_name }
  end

   # Публичный,  использовается в интерфейсе пользователя.
  def self.show_all_stations
    if @@stations.any?
      @@stations.each_with_index do |station, index| 
        puts "Index: #{index}, Station name: #{station.name}"
      end
    else
      puts Texts.no_stations
    end
  end

  #Публичный метод, используется в интерфейсе
  def train_arrive(train)
    @trains << train
  end

  #Публичный метод, используется в классе поезда
  def train_departure(train)
    raise 'No train in station' if @trains.nil?
    @trains.delete(train)
  end

  # Публичный, метод используется в интерфейсе
  def list_trains
    @trains.each do |train| 
      puts "Train number: #{train.number}"
    end
  end

  private

  def valid!(name)
    raise StandardError, "Input something, bitch." if name.nil?
    raise StandardError, "Station name should be have al least 3 letters." if name.size < 3
    raise StandardError, "Station name should be more than 3 or russian charters" if name !~ STATION_NAME_FORMAT
  end

end



