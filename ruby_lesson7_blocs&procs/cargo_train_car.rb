class CargoTrainCar < TrainCar

  attr_reader :type
  
  def initialize(size, load = 0, number = rand(0..999999))
    super(size, load, number)
    @type = 'Cargo'
  end

  def valid_load?(loaded)
    valid_load!(loaded)
    true
    rescue StandardError => e
      e
  end

  protected

  def valid_load!(loaded)
    raise StandardError, 'Enter something' if loaded.to_i.nil?
    raise StandardError, 'Cannot load this, load is too big' if free < loaded
  end
end