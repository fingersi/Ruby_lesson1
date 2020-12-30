class Texts

  def welcome_text
    '
    welcome to train sim app.
    '
  end

  # все методы этого класса используются в других классах

  def select_action
    '
    List stations/routes/trains enter 1
    Create station enter 2
    Create route enter 3
    Create train enter 4
    Change/add station to Route enter 5
    List trains in station enter 6
    Move train enter 7
    Add/delete train cars enter 8
    Add route to train enter 9
    Add manufacture for train enter 10
    Find train by number enter 11
    for exit press 0
    '
  end

  def display_select
    '
    Display all stations enter 1
    Display all Routes enter 2
    Display all train enter 3

    '
  end

  def wrong_input
    '
    Cannot get you, please enter something valid
    '
  end

  def add_station
    '
    Enter station name.
    '
  end

  def add_route
    '
    Select departure station and arrival station 
    '
  end

  def add_way_stations
    '
      If you want add stations enter 1
      if you not press 0
    '
  end

  def select_station_for_route
    '
      Enter index of the station for route
      for exit enter stop
    '
  end

  def choose_departure_station
    '
     Select duparture station, enter index
    '
  end

  def choose_arrival_station
    '
     Select arrival station, enter index
    '
  end

  def route_edit
    '
      add way stations for route enter 1
      delete way station from route enter 2 
    '
  end

  def select_route_for_editing
    '
    Select route, enter index of the route.
    '
  end

  def select_train
    '
    Select train, enter index of the route.
    '
  end

  def train_move_direction
    '
     Move train forward, enter 1
     Move train backward, enter 2
     for exit enter stop 
    '
  end

  def add_delete_train_car
    '
     if you want add train car enter 1
     id you want delete train car enter 2
     for exit enter stop
    '
  end

  def select_station
    '
     Select station, enter index of the  station.
    '
  end

  def create_train_name
    '
     Enter train name
    '
  end

  def select_train_type
    '
      If you want create cargo train, enter 1
      If you wnat cteate passenger train, enter 2
    '
  end

  def add_train_cars
    '
     How many trains cars you wnat to add
    '
  end

  def train_no_route
    '
     Before moving train, add any route to it
    '
  end

  def add_manufacturer
    '
      Enter manufacture name
    '
  end

  def self.no_train
    '
    There is no train, add one. 
    '
  end

  def no_train
    '
    There is no train, add one.
    '
  end

  def self.no_stations
    '
    There is no station, add one.
    '
  end

  def train_find
    '
      Enter number of the train
    '
  end

end