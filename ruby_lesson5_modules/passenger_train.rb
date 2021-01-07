class PassengerTrain < Train
  attr_reader :type

  self.class_init

  def initialize(number)
    super(number) 
    @type = 'passenger'
  end
end