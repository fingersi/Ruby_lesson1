
require_relative 'accessors'

class Train
  extend Accessors

  attr_accessor_with_history :current_station

  def initialize(number)
    @number = number
  end
end

