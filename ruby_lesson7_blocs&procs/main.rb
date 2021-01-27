require_relative 'train'
require_relative 'station'
require_relative 'route'
require_relative 'train_car'
require_relative 'passenger_train'
require_relative 'passenger_train_car'
require_relative 'cargo_train'
require_relative 'cargo_train_car'
require_relative 'text'
require_relative 'main_menu'
require_relative 'user_interface'
require_relative 'route_interface'
require_relative 'station_interface'
require_relative 'middleware'
require_relative 'train_interface'

class Main 

  @texts = Texts.new
  @train_int = TrainInterface.new(@texts)
  @route_int = RouteInterface.new(@texts)
  @station_int = StationInterface.new(@texts)
  
  def self.texts
    @texts
  end

  def self.train_int
    @train_int
  end

  def self.route_int
    @route_int
  end

  def self.station_int
    @station_int
  end

end

st1 = Station.new('Москва')
st2 = Station.new('Санкт-Петербург')
st3 = Station.new('Петушки')
st4 = Station.new('Луховицы')
st5 = Station.new('Одинцово')
route1 = Route.new(st1, st2)
route1.add_station(st3)
route1.add_station(st4)
route1.add_station(st5)
route2 = Route.new(st2, st1)
route2.add_station(st3)
tr1 = CargoTrain.new('123-00')
Main.train_int.add_train_cars(tr1, 100, 50, 'УВЗ', 11)
tr1.add_route(route1)
tr2 = PassengerTrain.new('a31-20')
Main.train_int.add_train_cars(tr2, 10, 5, 'ЖелДорМаш', 5)
Main.train_int.add_train_cars(tr2, 50, 10, 'Усть-урюпинский пепеткосборочный завод', 10)
tr2.add_route(route2)

puts Main.texts.welcome_text

MainMenu.new.action_select