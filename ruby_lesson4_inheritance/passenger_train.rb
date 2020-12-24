class PassengerTrain < Train
  attr_reader :type

  def initialize(number)
    super(number) 
    @type = 'passenger'
  end

  # добавить вагон
  # Если скорость = 0 и тип вагона  совпадает с типом поезда добавить вагон
=begin
  def add_train_car(train_car)
    if self.speed == 0 && self.type == train_car.type
      @train_cars << train_car
    else 
      puts 'Stop the train or check train car type'
    end
  end
=end
end