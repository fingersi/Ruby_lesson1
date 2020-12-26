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
require_relative 'middleware'

texts = Texts.new

puts texts.welcome_text

UserInterface.new(texts).action_select