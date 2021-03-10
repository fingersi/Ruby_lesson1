# frozen_string_literal: true

module ExceptionHadler
  def exeption_hadler(e)
    puts ''
    puts 'ExceptionHadler'
    puts "Exception Class: #{e.class.name}"
    puts "Exception Message: #{e.message}"
    puts "Exception Backtrace: #{e.backtrace}"
    puts ''
  end
end
