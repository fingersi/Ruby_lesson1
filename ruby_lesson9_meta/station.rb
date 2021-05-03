# frozen_string_literal: true

class Station

  attr_reader :name, :trains

  STATION_NAME_FORMAT = /^[а-я0-9]*([( )|-])?[а-я0-9]*$/i.freeze

  extend InstanceCounter::ClassMethods
  include InstanceCounter::InstanceMethods
  extend Validation::ClassMethods
  include Validation::InstanceMethods
  extend Accessors

  validate :name, :presence
  validate :name, :format, STATION_NAME_FORMAT

  @@stations = []

  def initialize(name)
    @name = name
    validate!
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

  def block_trains(station, block)
    station.trains.each { |train| block.call(train) }
  end

  def self.stations
    @@stations
  end

  def self.all
    @@stations
  end

  def self.find_by_name(station_name)
    @@stations.detect { |station| station.name == station_name }
  end

  def train_arrive(train)
    valid_train!(train)
    @trains << train
  end

  def train_departure(train)
    raise StandardError, 'No train in station' if @trains.nil?

    @trains.delete(train)
  end

  def block
    @trains
  end

  private

  def valid!(name)
    raise StandardError, 'Input something, bitch.' if name.nil?
    raise StandardError, 'Station name should be have al least 3 letters.' if name.size < 3
    raise StandardError, 'Station name should be more than 3 or russian charters' if name !~ STATION_NAME_FORMAT
  end

  def valid_train!(train)
    raise StandardError 'Objects is not a Train' unless train.is_a?(Train)
  end
end
