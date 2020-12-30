=begin 

module InstanceCounter
  @@instanse = 0

  def self.instances
    puts 'Instances'
    @@instanse
  end

end


class Wagon

  #include InstanceCounter::InstanceMethods
  extend InstanceCounter

  def initialize 
    puts 'I am here.'
  end  

  def register_instance
    @@instanse += 1
  end

end

w1 = Wagon.new

w2 = Wagon.new

=end

require_relative 'module1'
require_relative 'module2'

class AAA
  include A
  extend B
  def initialize
    register_instance
  end

  def s1
    puts 's11'
  end
end

class BBB < AAA
  def initialize
    puts 'class BBB'
  end
end

