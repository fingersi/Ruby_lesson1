module Validation
  module ClassMethods

    def validate(attr, type, *options)
      raise ArgumentError, 'type is not a symbol' unless type.is_a?(Symbol)

      @validations ||= []
      @validations << { attr: attr, type: type, options: options } 
    end

    def blabla
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


    def validate!

      @validations.each do |hash|

        puts "hash['type'] #{hash['type']}"

        puts "hash['type'] #{hash['attr']}"

        puts "hash['type'] #{hash['options']}"

        #raise TypeError, 'value is nil' if self.class.validate(value, :p)

        #raise TypeError, 'format is nil' if format.nil?

        #raise TypeError, 'format of value id wrong' if self.class.validate(value, :f, format)

        #raise TypeError, 'wrong type of value' if self.class.validate(value, :t, type)
      end

    end
  end
end
