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

  def strong_attr_accessor(name)
    var_name = "@#{name}".to_sym

    define_method(name) do
      instance_variable_get(var_name)
    end

    define_method("#{name}=") do |value|
      raise ArgumentError, 'wrong class of value' unless value[0].class != value[1]

      instance_variable_set(var_name, value[0])
    end
  end
end
