# frozen_string_literal: true

class CargoTrain < Train
  attr_reader :type

  validate :number, :presence
  validate :number, :format, TRAIN_NUMBER_FORMAT
  validate :number, :type, :String

  def initialize(number)
    super(number)
    @type = 'Cargo'
  end
end
