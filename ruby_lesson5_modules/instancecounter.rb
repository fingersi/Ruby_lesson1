module InstanceCounter

  module ClassMethods
    def class_init
      @instances = 0
    end

    def instances
      @instances
    end

    def add_instance
      @instances += 1
    end

    def instances= (number)
      @instances += number
    end
  end

  module InstanceMethods
    private
    def register_instance
      self.class.add_instance
    end
  end
end