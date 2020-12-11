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