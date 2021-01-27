require_relative 'exceptionhadler'

class MainMenu

  include ExceptionHadler

  def initialize
    @texts = Texts.new
    @train_int = TrainInterface.new(@texts)
    @route_int = RouteInterface.new(@texts)
    @station_int = StationInterface.new(@texts)
    @user_interface = UserInterface.new(@texts, @station_int, @route_int, @train_int )
    @middleware = MiddleWare.new(@texts)
  end

  def action_select
    loop do
      puts @texts.select_action
      input = gets.chomp
      case input
      when '0'
        break
      when '1'
        @user_interface.show_all_input
      when '2'
        @station_int.create_station
      when '3'
        @route_int.create_route
      when '4'
        begin
          @train_int.create_train
        rescue StandardError => e
          exeption_hadler(e)
        end

      when '5'
        begin
          @route_int.route_edit
        rescue StandardError => e
          exeption_hadler(e)
        end
      when '6'
        begin
          @user_interface.trains_on_station
        rescue StandardError => e
          exeption_hadler(e)
        end
      when '7'
        begin
          @user_interface.train_move
        rescue StandardError => e
          exeption_hadler(e)
        end
      when '8'
        begin
          @user_interface.add_delete_train_car
        rescue StandardError => e
          exeption_hadler(e)
        end
      when '9'
        begin
          @user_interface.train_add_route
        rescue StandardError => e
          exeption_hadler(e)
        end
      when '10'
        begin
          @user_interface.train_add_manufacturer
        rescue StandardError => e
          exeption_hadler(e)
        end
      when '11'
        begin
          @user_interface.train_find
        rescue StandardError => e
          exeption_hadler(e)
        end
      when '12'
        begin
          @user_interface.instances_number
        rescue StandardError => e
          exeption_hadler(e)
        end
      when '13'
        begin
          @user_interface.block_it
        rescue StandardError => e
          exeption_hadler(e)
        end
      when '14'
        begin
          @user_interface.show_train
        rescue StandardError => e
          exeption_hadler(e)
        end
      when '15'
        begin
          @user_interface.add_load
        rescue StandardError => e
          exeption_hadler(e)
        end
      else
        puts @texts.wrong_input
      end
    end
  end
end