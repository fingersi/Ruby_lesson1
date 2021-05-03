# All user input for Trains class.
class UserInputTrain < UserInput
  include ExceptionHadler

  def initialize(main, texts = Texts.new)
    super(main, texts)
  end

  def user_input_train_cars
    size_load = enter_load_size
    { number: enter_number, manufacturer: enter_manufacturer, size: size_load[0], load: size_load[1] }
  end

  def enter_load(size)
    loop do
      puts @texts.enter_load
      u_i_loaded = gets.chomp
      return u_i_loaded.to_i if u_i_loaded.to_i > size || TrainCar.valid_size?(u_i_loaded)
    end
  end

  def enter_size
    loop do
      puts @texts.enter_size
      u_i_size = gets.chomp
      return u_i_size.to_i if TrainCar.valid_size?(u_i_size)
    end
  end

  def enter_load_size
    sizei = enter_size
    load = enter_load(sizei)
    [sizei, load]
  end

  def enter_manufacturer
    loop do
      puts @texts.manufacturer
      u_i_manufacturer = gets.chomp
      return u_i_manufacturer if TrainCar.valid_manufacturer?(u_i_manufacturer)
    end
  end

  def enter_number
    loop do
      puts @texts.add_train_cars
      u_i_number = gets.chomp
      return u_i_number.to_i if Train.valid_train_cars?(u_i_number)
    end
  end

  def enter_train_number
    loop do
      puts @texts.create_train_number
      train_number = gets.chomp
      return train_number if Train.check_attr?(:number, train_number)
    end
  end

  def select_train
    loop do
      puts @texts.select_route_for_editing
      user_input = gets.chomp
      raise StandardError, 'User stops input' if user_input == 'stop'

      return Train.trains[user_input.to_i] unless Train.trains[user_input.to_i].nil?

      puts @texts.wrong_input
    end
  end

  def find_train
    loop do
      puts @texts.train_find
      user_input = gets.chomp
      return user_input unless user_input.nil?
    end
  end

  def add_load
    loop do
      puts @texts.add_load
      user_input_load = gets.chomp
      return user_input_load if train_car.valid_load?(user_input_load)
    end
  end
end
