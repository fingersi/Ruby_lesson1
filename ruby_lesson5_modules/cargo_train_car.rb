class CargoTrainCar < TrainCar
  attr_reader :type
  
  def initialize
    @type = 'cargo'
  end 

end