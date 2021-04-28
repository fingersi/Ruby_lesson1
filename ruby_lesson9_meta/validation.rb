module Validation
  module ClassMethods
    def validate(attr, type, *options)
      raise ArgumentError, 'type is not a symbol' unless type.is_a?(Symbol)

      @validations ||= []
      @validations << { attr: attr, type: type, options: options }
    end

    def validations
      @validations ||= []
      @validations
    end
  end

  module InstanceMethods
    def validations
      self.class.validations
    end

    def check_type(var, klass)
      return true if var.instance_of?(Object.const_get(klass))

      false
    end

    def check_format(variable, format)
      regexp = check_regexp(format)

      return true unless variable !~ regexp

      false
    end

    def check_regexp(format)
      if format.instance_of?(Regexp)
        format
      else
        Regexp.quote(format)
      end
    end

    def presence(attr)
      raise StandartError 'instance variable is nil' if instance_variable_get("@#{attr}").nil?

      true
    end

    def validate!
      validations.each do |hash|
        case hash[:type]
        when :presence
          raise TypeError, 'value is nil' unless presence(hash[:attr])
        when :format
          raise TypeError, 'format of value id wrong' if check_format(hash[:attr], hash[:options][0])
        when :type
          raise TypeError, 'wrong type of value' if check_type(hash[:attr], hash[:options][0])
        end
      end
    end

    def validate? 
      validations.each do |hash|
        case hash[:type]
        when :presence
          return false unless presence(hash[:attr])
        when :format
          return false if check_format(hash[:attr], hash[:options][0])
        when :type
          return false if check_type(hash[:attr], hash[:options][0])
        end
      end
      true
    end
  end
end
