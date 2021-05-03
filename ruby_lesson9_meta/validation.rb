module Validation
  module ClassMethods
    def validations
      @validations ||= []
      @validations
    end

    def validate(attr, type, *options)
      raise ArgumentError, 'type is not a symbol' unless type.is_a?(Symbol)

      @validations ||= []
      @validations << { attr: attr, type: type, options: options }
    end

    def check_attr!(attr, value)
      validations.each do |validation|
        next if validation[:attr] != attr

        send("validate_#{validation[:type]}", value, *validation[:options])
      end
      true
    end

    def check_attr?(attr, value)
      check_attr!(attr, value)
    rescue StandardError => e
      exeption_hadler(e)
      false
    end

    def validate_type(value, *options)
      options.each do |option|
        return true if value.instance_of?(Object.const_get(option))
      end
      false
    end

    def validate_format(value, *options)
      options.each do |format|
        raise TypeError, 'format of value is wrong' if value !~ check_regexp(format)
      end
      true
    end

    def check_regexp(format)
      if format.instance_of?(Regexp)
        format
      else
        Regexp.quote(format)
      end
    end

    def validate_presence(value)
      raise StandardError, 'instance variable is nil' if value.nil?
      raise StandardError, 'instance variable is empty' if value == ''

      true
    end
  end

  module InstanceMethods
    def validations
      self.class.validations ||= []
      self.class.validations
    end

    def validate_presence(value)
      self.class.validate_presence(value)
    end

    def validate_format(value, *options)
      self.class.validate_format(value, *options)
    end

    def validate_type(value, *options)
      self.class.validate_type(value, *options)
    end

    def validate!
      validations.each do |validation|
        value = instance_variable_get("@#{validation[:attr]}")
        send("validate_#{validation[:type]}", value, *validation[:options]) 
      end
    end

    def validate?
      validations.each do |validation|
        value = instance_variable_get("@#{validation[:attr]}")
        begin
          send("validate_#{validation[:type]}", value, *validation[:options]) 
        rescue StandardError
          return false
        end
      end
      true
    end
  end
end
