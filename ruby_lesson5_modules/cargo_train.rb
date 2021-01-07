class CargoTrain < Train
  attr_reader :type

  self.class_init
  
  def initialize(number)
    super(number) 
    @type = 'cargo'
  end

end