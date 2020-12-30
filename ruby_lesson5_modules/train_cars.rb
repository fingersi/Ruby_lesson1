
require_relative 'manufacturer'

class TrainCar

  include Manufacturer
  
  def add_to_train(train)
    if train.type == self.type
      train.train_cars << self
    end
  end
end