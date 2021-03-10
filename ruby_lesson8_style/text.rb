class Texts < Texts2
  def welcome_text
    '
    welcome to train sim app.
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
      If you not press 0
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

  def last_station_on_route
    'Train is on last station on the route. Please add new route.'
  end

  def first_station
    'Train is on departure station on the route.'
  end

  def no_train_in_station
    'There is no train in station.'
  end
end
