require_relative 'text'

class StationInterface

  def initialize(texts)
    @texts = texts
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
    loop do
      Main.station_int.show_all_stations
      puts @texts.select_station
      user_input = gets.chomp
      return if Train.trains.empty?
      if user_input == 'stop'
        break
      elsif !user_input.to_i.nil?
        return Station.stations[user_input.to_i]
      else
        puts @texts.wrong_input
      end
    end
  end

  def show_station_trains(station)
    station.trains.each do |train| 
      puts "Train number: #{train.number} Train type: #{train.type} Cargo Trains: #{train.train_cars.size}"
    end
  end
end