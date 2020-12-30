class Station
  attr_reader :name

  @@stations = []
  
  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
  end

  # Публичный, использовается в интерфейсе пользователя.
  def self.stations
    @@stations
  end

  def self.all 
    @@stations
  end
  
  # Публичный,  использовается в интерфейсе пользователя. Yt
  def self.find_by_name(station_name)
    @@stations.detect{ |station| station.name == station_name}
  end

   # Публичный,  использовается в интерфейсе пользователя.
  def self.show_all_stations
    index = 0
    if @@stations.any?
      @@stations.each do |station| 
        puts "Index: #{index}, Station name: #{station.name}"
        index += 1
      end
    else
      puts Texts.no_stations
    end
  end

  #Публичный метод, используется в интерфейсе
  def train_arrive(train)
    @trains << train
  end

  #Публичный метод, используется в классе поезда
  def train_departure(train)
    return 'No train in station' if @trains.nil?
    @trains.delete(train)
  end

  # Публичный, метод используется в интерфейсе
  def list_trains
    @trains.each do |train| 
      puts "Train number: #{train.number}"
    end
  end
end



