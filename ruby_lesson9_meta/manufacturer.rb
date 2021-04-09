# frozen_string_literal: true

module Manufacturer
  module InstanceMethods
    attr_accessor :manufacturer
  end

  module ClassMethods
    def valid_manufacturer?(name)
      valid_manufacturer!(name)
      true
    rescue StandardError => e
      exeption_hadler(e)
      false
    end

    def valid_manufacturer!(name)
      raise StandardError, 'Manufacturer name should have 1 letter' if name.nil?
    end
  end
end
