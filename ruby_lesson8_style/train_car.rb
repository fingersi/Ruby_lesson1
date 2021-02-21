require_relative 'manufacturer'
require_relative 'exceptionhadler'

class TrainCar
  extend Manufacturer::ClassMethods
  include Manufacturer::InstanceMethods
  extend ExceptionHadler
  attr_reader :number, :load

  SIZE_LOAD_FORMAT = /^[0-9]{1,7}$/ 

  def initialize(size, load, number = rand(1..1_000_000), manufacturer = '')
    @number = number
    @load = load
    @size = size
    @manufacturer = manufacturer
  end

  def self.valid?(size, load)
    valid!(size, load)
    true
  rescue StandardError => e
    exeption_hadler(e)
    false
  end

  def self.valid_load?(load)
    valid_load!(load)
    true
  rescue StandardError => e
    exeption_hadler(e)
    false
  end

  def self.valid_size?(size)
    valid_size!(size)
    true
  rescue StandardError => e
    exeption_hadler(e)
    false
  end

  def self.valid!(size, load)
    raise StandardError, 'Size and Load should have 1 - 7 figures' if size !~ SIZE_LOAD_FORMAT || load !~ SIZE_LOAD_FORMAT
    raise StandardError, 'Load is bigger that size' if size.to_i < load.to_i
  end

  def self.valid_load!(load)
    raise StandardError, 'enter digits' unless load !~ SIZE_LOAD_FORMAT
  end

  def self.valid_size!(size)
    raise StandardError, 'Train car size should only digits ' if size !~ SIZE_LOAD_FORMAT
  end

  def add_load(load)
    raise StandardError, 'Load is too big' if free < load

    @load += load
  end

  def free
    @size - @load
  end

  def add_to_train(train)
    train.train_cars << self if train.type == type
  end

  def valid_load!(load)
    raise StandardError, 'load too big' if load > free
    raise StandardError, 'enter digits' unless load !~ SIZE_LOAD_FORMAT
  end
end
