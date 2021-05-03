
require_relative 'accessors'
require_relative 'validation'
require_relative 'classlevelinheritableattributes'


class Train

  extend Validation::ClassMethods
  include Validation::InstanceMethods
  extend ClassLevelInheritableAttributes::ClassMethods

  inheritable_attributes :validations

  TRAIN_NUMBER_FORMAT = /^[а-я0-9]{3}([( )|-])?[а-я0-9]{2}$/i.freeze
  TRAIN_CARS_FORMAT = /^[0-9]{1,3}$/.freeze

  validate :number, :presence
  validate :number, :format, TRAIN_NUMBER_FORMAT
  validate :number, :type, :String

  extend Accessors

  attr_accessor_with_history :current_station

  def initialize(number)
    @number = number
  end
end

class CargoTrain < Train

end

