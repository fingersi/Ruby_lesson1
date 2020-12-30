=begin
module InstanceCounter

  module ClassMethods
    @@instanse = 0

    def  self.instances
      @@instanse
    end
  end

#module InstanceMethods

end
=end
module B
  @@aaa = 0
  def instances
    @@aaa
  end
end