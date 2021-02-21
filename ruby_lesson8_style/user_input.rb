require_relative 'exceptionhadler'

class UserInput

  include ExceptionHadler

  def initialize(texts)
    @texts = texts
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
      return train_number if Train.valid?(train_number)
    end
  end

  def show_all_input
    loop do
      puts @texts.display_select
      user_input = gets.chomp
      return if user_input == 'stop'
      return user_input if %w[1 2 3].include?(user_input)

      puts @texts.wrong_input
    end
  end

  def select_action(text)
    puts text
    user_input = gets.chomp
    return if user_input == 'stop'
    return user_input if %w[1 2].include?(user_input)

    puts @texts.wrong_input
  end

  def select_departure_station
    loop do
      Main.station_int.show_all_stations
      puts @texts.choose_departure_station
      departure_station_index = gets.chomp.to_i
      return departure_station_index if Route.index_valid?(departure_station_index)

      puts @texts.wrong_input
    end
  end

  def select_arrival_station(departure_station_index)
    loop do
      puts @texts.choose_arrival_station
      arrival_station_index = gets.chomp.to_i
      if Route.index_valid?(arrival_station_index) && departure_station_index != arrival_station_index
        return arrival_station_index 
      end

      puts @texts.wrong_input
    end
  end

  def select_route
    loop do
      puts @texts.select_route_for_editing
      user_input = gets.chomp
      raise StandardError, 'User stops input' if user_input == 'stop'

      return Route.routes[user_input.to_i] unless Route.routes[user_input.to_i].nil?

      puts @texts.wrong_input
    end
  end
end
