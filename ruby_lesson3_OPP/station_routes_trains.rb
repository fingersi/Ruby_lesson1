class Station
  attr_reader :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def list_trains(trains = @trains)
    trains.each{|train| puts train.number}
  end

  def list_trains_by_type(type)
    puts "@trains.nil? #{@trains.nil?}"
    if @trains.nil?
      puts 'There is on trains at station' 
    end
    self.list_trains(@trains.select{ |train| train.type == type })
  end

  def trains_by_type(type)
    @trains.each{|train| puts train.number if train.type == type}
  end

  def train_arrive(train)
    @trains << train
  end

  def train_departure(train)
    return 'No train in station' if @trains.nil?
    @trains.delete(train)
  end

end

class Route
  attr_reader :departure_station, :arrival_station, :way_stations

  def initialize(departure_station, arrival_station)
    @departure_station = departure_station
    @arrival_station = arrival_station
    @way_stations = []
  end

  def add_station(station)
    @way_stations << station
  end

  def delete_station(station)
    puts 'You cannot delete departure station' if station == @departure_station
    puts 'You cannot delete arrival station' if station == @arrival_station
    @way_stations.delete(station) 
  end

  def show_stations
    self.build_route.each{|station| puts station.name}
  end

  def build_route
    build_route = []
    build_route << departure_station
    @way_stations.each{ |way_station| build_route << way_station }
    build_route << arrival_station
    return build_route
  end

end

class Train
  attr_accessor :number, :speed
  attr_reader :type, :current_station

  def initialize()
    @current_station 
    @route
    @speed = 0

    loop do
      puts 'Please add train number, string:'
      @number = gets.chomp
      puts "Please add train cars number, number"
      input_cars_number = gets.chomp
      puts 'Please add train type, cargo or passenger'
      type_input = gets.chomp
      check_cars_number = input_cars_number.scan(/^-?[0-9]+$/).any?

      if type_input == 'cargo' && check_cars_number
        @type = 'cargo'
        @train_cars_number = input_cars_number.to_i
        break
      elsif type_input == 'passenger' && check_cars_number
        @type = 'passenger'
        @train_cars_number = input_cars_number.to_i
        break
      elsif input_cars_number == 'stop' || type_input == 'stop' || @number == 'stop'
        break
      else
        puts 'input error, check train type or cars number.'
      end

    end
  end
  
  def check_train_type(type)
    if type == 'cargo'
      return 'cargo'
    elsif type == 'passangers'
      return 'passangers'
    else
      puts 'input error check train type'
    end
  end

  def brake 
    @speed = 0
  end

  def show_train_cars_number
    puts "train_cars_number: #{train_cars_number}"
  end

  def delete_train_car
    if @speed == 0
      @train_cars_number -= 1 if @train_cars_number > 0
      puts "Train car has been deleted. 
      train_cars_number: #{@train_cars_number}"
    else
     puts "Stop train before deleting train cars "
    end
  end

  def add_train_car
    if @speed == 0

      @train_cars_number += 1
      puts "You have added on train car.
       train_cars_number: #{@train_cars_number}"
    else
     puts "Stop train before adding train cars "
    end
  end
  
  def add_route(route)
    @route = route
    self.change_station(route.departure_station)
    puts "Train has moved to #{@current_station.name}"
  end

  def move_forward
    close_stations = self.stations_on_route
    if close_stations[2].nil?
      puts 'Train is on last station on the route. Please add new route.'
    else
      self.change_station(close_stations[2])
      puts "Train has moved to station: #{@current_station.name}"
    end
  end

  def move_backward
    close_stations = self.stations_on_route
    if close_stations[0].nil?
      puts 'Train is at departion station on the route. You can only move train forward.'
    else
      self.change_station(close_stations[0])
      puts "Train has moved to station: #{@current_station.name}."
    end
  end

  def stations_on_route
    index = 0
    builded_route = @route.build_route
    prev_st = 0
    current_st = 0
    next_st = 0
    builded_route.each do |station| 
      if station == @current_station
        index == 0 ? prev_st = nil : prev_st = builded_route[index - 1]
        index == builded_route.size ? next_st = nil : next_st = builded_route[index + 1]
  
        return [prev_st, @current_station, next_st]
      end
      index += 1
    end
  end

  def change_station(station)
    @current_station.train_departure(self) if !@current_station.nil?
    station.train_arrive(self)
    @current_station = station
    return station
  end

  def show_station_on_route
    puts " stations_on_route: #{stations_on_route.class}"
    self.stations_on_route.each{ |station| puts station.name if !station.nil?}
  end
  
end