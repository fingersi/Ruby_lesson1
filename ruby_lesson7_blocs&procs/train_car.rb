
require_relative 'manufacturer'

class TrainCar

  attr_reader :number

  SIZE_LOAD_FORMAT = /^[0-9]{7}$/ 

  include Manufacturer

  def initialize(number = rand(1..1000000))
    @number = number
  end
  
  def add_to_train(train)
    if train.type == self.type
      train.train_cars << self
      @number = Random.rand(1...999999)
    end
  end

end