module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym

      define_method(name) do
        instance_variable_get(var_name).last
      end

      define_setter(name, var_name)

      define_method("#{name}_history") do
        instance_variable_get(var_name)
      end
    end
  end

  def define_setter(name, var_name)
    define_method("#{name}=") do |value|
      var = instance_variable_get(var_name)
      var ||= []
      instance_variable_set(var_name, var << value)
    end
  end

  def strong_attr_accessor(*arg)
    arg.each_with_index do |argument, index|
      next if index.odd?

      var_name = "@#{argument}".to_sym

      define_method(argument) do
        instance_variable_get(var_name)
      end

      define_method("#{argument}=") do |value|
        klass = arg[index + 1]
        raise ArgumentError, 'wrong class of value' unless value.instance_of?(Object.const_get(klass))

        instance_variable_set(var_name, value)
      end
    end
  end
end
