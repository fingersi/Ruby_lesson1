require_relative 'exceptionhadler'

class UserInput

  include ExceptionHadler

  def initialize(texts)
    @texts = texts
  end

  def user_input_train_cars
    { number: enter_number, manufacturer: enter_manufacturer, size: u_i_size, load: u_i_loaded }
  end

  def enter_load
    loop do
      puts @texts.enter_load
      u_i_loaded = gets.chomp
      break if Train_car.valid_load?(u_i_loaded)
      u_i_loaded.to_i
    end
  end

  def enter_size
    loop do
      puts @texts.enter_size
      u_i_size = gets.chomp
      break if Train_car.valid_size?(u_i_size)
      u_i_size.to_i
    end
  end

  def enter_manufacturer
    puts @texts.manufacturer
    u_i_manufacturer = gets.chomp
    Train_car.valid_manufacturer!(u_i_manufacturer)
    u_i_manufacturer
  end

  def enter_number
    puts @texts.add_train_cars
    u_i_number = gets.chomp
    Train.valid_train_cars!(u_i_number)
  end

end