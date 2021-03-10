module InstanceCounter
  # Inteance counter
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

  # Instance add methods
  module InstanceMethods
    private

    def register_instance
      self.class.add_instance
    end
  end
end
