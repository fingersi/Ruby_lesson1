# frozen_string_literal: true

# All user inputs for Station class
class UserInputStation < UserInput
  include ExceptionHadler

  def initialize(main, texts = Texts.new)
    super(main, texts)
  end

  def station_select
    loop do
      @main.station_int.show_all_stations
      puts @texts.select_station
      user_input = gets.chomp
      return if user_input == 'stop'
      return Station.stations[user_input.to_i] unless user_input.to_i.nil?

      puts @texts.wrong_input
    end
  end
end
