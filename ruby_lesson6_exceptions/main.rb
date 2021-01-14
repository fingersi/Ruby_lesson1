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
tr1 = CargoTrain.new('123')
tr1.add_train_cars(11, 'УВЗ')

texts = Texts.new

puts texts.welcome_text

UserInterface.new(texts).action_select