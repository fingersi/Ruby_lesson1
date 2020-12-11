class Train
  attr_accessor :number, :speed
  attr_reader :type, :current_station, :type_id

  def initialize(number, type_id, train_cars_number)
    #@current_station 
    #@route
    @speed = 0 # Значение скорости по умолчанию
    @number = number
    @type_id = type_id
    @types = ['cargo', 'passenger'] 
    @train_cars_number = train_cars_number
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
    next_station = self.next_station
    if next_station.nil?
      puts 'Train is on last station on the route. Please add new route.'
    else
      self.change_station(next_station)
      puts "Train has moved to station: #{@current_station.name}"
    end
  end

  def move_backward
    prev_station = self.prev_station
    if prev_station.nil?
      puts 'Train is at departion station on the route. You can only move train forward.'
    else
      self.change_station(prev_station)
      puts "Train has moved to station: #{@current_station.name}."
    end
  end

  def next_station
    route_stations = @route.stations
    st_index = route_stations.index(@current_station)
    st_index == route_stations.size ? (return nil) : (return @route.stations[st_index + 1])
  end

  def show_next_station
    if @current_station.nil?
      puts 'Trains has no route.'
    else
      next_station = self.next_station
      if next_station.nil?
       puts 'Train is on last station on the route. Please add new route.'
      else 
        puts "Train's next station is #{@route[st_index + 1]}"
      end 
    end
  end

  def prev_station
    route_stations = @route.stations
    st_index = route_stations.index(@current_station)
    st_index == 0 ? (return nil) : (return route_stations[st_index - 1])  
  end

  def show_prev_station   
    if @current_station.nil?
      puts 'Trains has no route.'
    else
     self.prev_station.nil? ? (puts 'Train is on departure station on the route.') : 
     (puts "Train's previous station is #{@route[st_index - 1]}")
    end
  end

  def show_current_station
    @current_staion.nil? ? (puts "Train is in nowhere =)") : (puts "Train's current station is: #{@current_station.name}")
  end

  def change_station(station)
    @current_station.train_departure(self) if !@current_station.nil?
    station.train_arrive(self)
    @current_station = station
    return station
  end

  def stations_on_route
    index = 0
    route_staions = @route.stations
    #prev_st = 0
    #current_st = 0
    #next_st = 0
    route_staions.each do |station| 
    if station == @current_station
      index == 0 ? prev_st = nil : prev_st = route_staions[index - 1]
      index == route_staions.size ? next_st = nil : next_st = route_staions[index + 1]
      return [prev_st, @current_station, next_st]
    end
      index += 1
    end
  end

  def show_stations_on_route
    if @current_station.nil?
      puts 'Trains has no route.'
    else
      self.stations_on_route.each{ |station| puts station.name if !station.nil?}
    end
  end
end