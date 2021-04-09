# frozen_string_literal: true

class PassengerTrainCar < TrainCar
  attr_reader :type

  def initialize(size, load = 0, number = rand(1..1_000_000))
    super(size, load, number)
    @type = 'Passenger'
  end

  def add_load
    raise StandardError, 'There is no more free seats' if free < 1

    @load += 1
  end
end
