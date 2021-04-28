# Main Class in TrainSim app
class Main
  attr_reader :texts
  attr_accessor :train_int, :route_int, :station_int, :user_input,
                :user_input_route, :user_input_station, :user_interface,
                :user_input_train, :train_car_int

  def initialize
    @texts = Texts.new
    @train_int = TrainInterface.new(self, @texts)
    @route_int = RouteInterface.new(self, @texts)
    @station_int = StationInterface.new(self, @texts)
    @train_car_int = TrainCarInterface.new(self, @texts)
    @user_input = UserInput.new(self, @texts)
    @user_input_train = UserInputTrain.new(self, @texts)
    @user_input_route = UserInputRoute.new(self, @texts)
    @user_input_station = UserInputStation.new(self, @texts)
    start_stations
  end

  def start_stations
    st1 = Station.new('Москва')
    st2 = Station.new('Санкт-Петербург')
    st3 = Station.new('Петушки')
    st4 = Station.new('Луховицы')
    st5 = Station.new('Одинцово')
    start_routes(st1, st2, st3, st4, st5)
  end

  def start_routes(st1, st2, st3, st4, st5)
    puts 'Create routes'
    route1 = Route.new(st1, st2)
    route1.add_station(st3)
    route1.add_station(st4)
    route1.add_station(st5)
    route2 = Route.new(st2, st1)
    route2.add_station(st3)
    puts 'routes created'
    start_trains(route1, route2)
  end

  def start_trains(route1, route2)
    tr1 = CargoTrain.new('123-00')
    @train_int.add_train_cars(tr1, size: 100, load: 50, manufacturer: 'УВЗ', number: 11)
    tr1.add_route(route1)
    tr2 = PassengerTrain.new('а00-20')
    @train_int.add_train_cars(tr2, size: 10, load: 5, manufacturer: 'ЖелДорМаш', number: 5)
    @train_int.add_train_cars(tr2, size: 50, load: 10, manufacturer: 'Красное сармово', number: 10)
    tr2.add_route(route2)
  end
end
