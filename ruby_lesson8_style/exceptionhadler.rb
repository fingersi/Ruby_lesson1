module ExceptionHadler
  def exeption_hadler(error)
    puts ''
    puts 'ExceptionHadler'
    puts "Exception Class: #{error.class.name}"
    puts "Exception Message: #{error.message}"
    puts "Exception Backtrace: #{error.backtrace}"
    puts ''
  end
end
