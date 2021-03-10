class TrainCarInterface
  def initialize(main, texts)
    @texts = texts
    @main = main
  end

  def add_load(load, train_car)
    if train.train_cars[load].type == 'Cargo'
      train_car.add_load(load)
    else
      load.times { train.train_cars[load].add_load }
    end
  end

  def create_train_car(train, user_input)
    return CargoTrainCar.new(user_input[:size], user_input[:load]) if train.type == 'Cargo'

    PassengerTrainCar.new(user_input[:size], user_input[:load])
  end
end
