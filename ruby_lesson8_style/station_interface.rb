# frozen_string_literal: true

# All  methodes to Station class
class StationInterface
  def initialize(main, texts)
    @texts = texts
    @main = main
  end

  def  show_all_stations
    if Station.stations.any?
      Station.stations.each_with_index do |station, index|
        puts "Index: #{index}, Station name: #{station.name}"
        show_station_trains(station)
      end
    else
      puts Texts.no_stations
    end
  end

  def create_station
    loop do
      puts @texts.add_station
      station_name = gets.chomp
      if !station_name.nil?
        show_all_stations if Station.new(station_name)
        break
      else
        puts @texts.wrong_input
      end
    end
  end

  def select_station
    raise StandardError, 'No train, add one.' if Train.trains.empty?

    user_input = @main.user_input_station.station_select
    return Station.stations[user_input.to_i] unless user_input.nil?
  end

  def show_station_trains(station)
    station.trains.each do |train|
      puts "Train number: #{train.number} Train type: #{train.type} Cargo Trains: #{train.train_cars.size}"
    end
  end
end
