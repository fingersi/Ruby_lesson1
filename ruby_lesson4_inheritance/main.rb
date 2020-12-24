require_relative 'trains'
require_relative 'stations'
require_relative 'routes'

require_relative 'train_cars'
require_relative 'passenger_train'
require_relative 'passenger_train_car'
require_relative 'cargo_train'
require_relative 'cargo_train_car'

require_relative 'texts'
require_relative 'user_interface'

=begin
puts 'Train Sim app welcomes you'
puts 'You can add some Stations, Routes, Trains and Train cars'
puts 'Also you can add route to train or add train car to train'
puts 'Enjoy'
=end

texts = Texts.new

puts texts.welcome_text

st1 = Station.new('Москва')
st2 = Station.new('Санкт-Петербург')
st3 = Station.new('Петушки')
st4 = Station.new('Луховицы')
st5 = Station.new('Одинцово')
route1 = Route.new(st1, st2)
route1.add_station(st3)
route1.add_station(st4)
#route1.add_station(st5)
tr1 = CargoTrain.new(123)
tr1.add_train_cars(11)


UserInterface.new(texts).action_select