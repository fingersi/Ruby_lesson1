
require_relative 'manufacturer'

class TrainCar

  attr_reader :number, :load

  SIZE_LOAD_FORMAT = /^[0-9]{1,7}$/ 

  include Manufacturer

  def initialize(size, load, number = rand(1..1000000), manufacturer = '')
    @number = number
    @load = load
    @size = size
    @manufacturer = manufacturer
  end

  def self.valid?(size, load)
    valid!(size, load)
    true
  rescue StandardError
    false
  end

  def self.valid!(size, load)
    raise StandardError, "Size and Load should have 1 - 7 figures" if size !~ SIZE_LOAD_FORMAT || load !~ SIZE_LOAD_FORMAT
    raise StandardError, "Load is bigger that size" if size.to_i < load.to_i
  end

  def add_load(load)
    raise StandardError, 'Load is too big' if free < load
    @load += load 
  end

  def free
    @size - @load
  end
  
  def add_to_train(train)
    if train.type == self.type
      train.train_cars << self
    end
  end

end