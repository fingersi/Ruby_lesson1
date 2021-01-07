module ZZZ

  def insts= (number)
    @insts += number
  end

  def add_inst
    puts 'I am in add inst'
    @insts += 1
    puts "add_inst,insts #{insts}"
  end

  def insts
    puts "instances: #{@insts}"
    @insts
  end

  def init_insts
    @insts = 0
  end

  def aaa
    puts ' I am here'
  end

end


class MainA

  extend ZZZ

  #@insts = 0
  self.init_insts
  def initialize
    self.class.add_inst
  end

end

class SonA < MainA
  self.init_insts
  def initialize
    self.class.add_inst
    puts 'SonA'
  end
end
