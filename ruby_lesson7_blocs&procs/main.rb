require_relative 'train'
require_relative 'station'
require_relative 'route'
require_relative 'train_car'
require_relative 'passenger_train'
require_relative 'passenger_train_car'
require_relative 'cargo_train'
require_relative 'cargo_train_car'
require_relative 'text'
require_relative 'user_interface'
require_relative 'middleware'

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
tr1.add_train_cars(100, 50, 'УВЗ', 11)
tr1.add_route(route1)
tr2 = PassengerTrain.new('a31-20')
tr2.add_train_cars(10, 5, 'ЖелДорМаш', 5)
tr2.add_train_cars(50, 10, 'Усть-урюпинский пепеткосборочный завод', 10)
tr2.add_route(route2)


texts = Texts.new

puts texts.welcome_text

UserInterface.new(texts).action_select