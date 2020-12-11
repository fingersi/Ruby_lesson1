class Route
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
    self.stations.each{|station| puts station.name}
  end

  def stations
    [@departure_station, @way_stations, @arrival_station].flatten
  end
end