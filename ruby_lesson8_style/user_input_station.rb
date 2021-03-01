require_relative 'exceptionhadler'

class UserInputStation
  include ExceptionHadler

  def initialize(texts)
    @texts = texts
  end

  def station_select
    loop do
      Main.station_int.show_all_stations
      puts @texts.select_station
      user_input = gets.chomp
      return if user_input == 'stop'
      return Station.stations[user_input.to_i] unless user_input.to_i.nil?

      puts @texts.wrong_input
    end
  end
end
