class PassengerTrainCar < TrainCar
  attr_reader :type
  
  def initialize(seats, loaded = 0, number = rand(1..1000000))
    super(number)
    @type = 'Passenger'
    @seats = seats
    @occupied = loaded
  end

  def take_seat
    raise StandardError, 'There is no more free seats' if @occupied == @seats
    @occupied += 1
  end

  def free
    @seats - @occupied
  end

  def load
    @occupied
  end
end