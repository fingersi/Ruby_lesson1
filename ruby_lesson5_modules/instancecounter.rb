module InstanceCounter

  module ClassMethods

    def instances
      @instances ||= 0
      @instances
    end

    def add_instance
      @instances ||= 0
      @instances += 1
    end
  end

  module InstanceMethods

    private
    
    def register_instance
      self.class.add_instance
    end
  end
end