class Station
  attr_reader :name

  @@stations = []
  
  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
  end

  # Публичный,  использовается в интерфейсе пользователя.
  def self.stations
    @@stations
  end

  # Публичный,  использовается в интерфейсе пользователя. Yt
=begin
  def self.find_by_name(station_name)
    @@stations.detect{ |station| station.name == station_name}
  end
=end

   # Публичный,  использовается в интерфейсе пользователя. Yt
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

  def list_trains(trains = @trains)
    trains.each { |train| puts train.number }
  end

  def list_trains_by_type_name(type)
    if @trains.nil?
      puts 'There is on trains at station' 
    end
      self.list_trains(@trains.select{ |train| train.type == type })
  end

  def list_trains_by_type_id(type_id)
    if @trains.nil?
      puts 'There is on trains at station' 
    end
      self.list_trains(@trains.select{ |train| train.type_id == type_id })
  end 

  def trains_by_type(type)
    @trains.each{|train| puts train.number if train.type == type}
  end

  def train_arrive(train)
    @trains << train
  end

  def train_departure(train)
    return 'No train in station' if @trains.nil?
    @trains.delete(train)
  end
end



