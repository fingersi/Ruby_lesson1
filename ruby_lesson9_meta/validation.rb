module Validation
  module ClassMethods
    def validate(value, type, data = nil)
      raise ArgumentError, 'type is not a symbol' unless type.is_a?(Symbol)

      var = right_var(value)
      case type
      when :presence
        return true unless var.nil?
      when :format
        return check_format(var, data)
      when :type
        return check_type(var, data)
      end
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

    def right_var(value)
      if value.instance_of?(Symbol)
        instance_variable_get(value)
      else
        value
      end
    end

    def check_type(var, klass)
      return true if var.instance_of?(Object.const_get(klass))

      false
    end
  end

  module InstanceMethods
    def validate!(value, format = nil, type = nil)
      raise TypeError, 'value is nil' if self.class.validate(value, :p)

      raise TypeError, 'format is nil' if format.nil?

      raise TypeError, 'format of value id wrong' if self.class.validate(value, :f, format)

      raise TypeError, 'wrong type of value' if self.class.validate(value, :t, type)
    end

    def validate?(value, format = nil, type = nil)
      alidate!(value, format, type)
      true
    rescue TypeError => e
      exeption_hadler(e)
      false
    end
  end
end
