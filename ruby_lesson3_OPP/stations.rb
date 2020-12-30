class Station
  attr_reader :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def list_trains(trains = @trains)
    trains.each{|train| puts train.number}
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



