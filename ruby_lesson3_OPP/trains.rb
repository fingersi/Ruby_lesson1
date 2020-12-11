class Train
  attr_accessor :number, :speed
  attr_reader :type, :current_station, :type_id

  def initialize(number, type_id, train_cars_number)
    @current_station 
    @route
    @speed = 0
    @number = number
    @type_id = type_id
    @types = ['cargo', 'passenger'] 
  end

  def type
    @types[@type_id]
  end

  def id_by_type_name(type_name)
    @types.find_index(type_name)
  end

  def stop 
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
    self.stations_on_route.each{ |station| puts station.name if !station.nil?}
  end
  
end