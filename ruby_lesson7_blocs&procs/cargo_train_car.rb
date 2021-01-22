class CargoTrainCar < TrainCar

  attr_reader :type
  
  def initialize(volume, loaded = 0, number = rand(0..999999))
    super(number)
    @type = 'Cargo'
    @volume = volume
    @cargo = loaded
  end

  def add_load(pay_load)
    @cargo += pay_load
  end

  def load
    @cargo
  end

  def free
    @volume - @cargo
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