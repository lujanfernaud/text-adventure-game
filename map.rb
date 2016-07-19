require './rooms.rb'

class Map
  
  attr_reader :cave_map, :rooms_list

  def initialize
    @cave_map = 
      ["entrance", "room 1", "room 2", "room 3", "room 4",
       "locked", "room 5", "room 6", "room 7", nil,
       "room 8", "room 9", nil, "room 10", "exit"]

    @rooms_list = 
      { "entrance" => Entrance.new,
        "room 1" => Room1.new,
        "room 2" => Room2.new,
        "room 3" => Room3.new,
        "room 4" => Room4.new,
        "locked" => Locked.new,
        "room 5" => Room5.new,
        "room 6" => Room6.new,
        "room 7" => Room7.new,
        "room 8" => Room8.new,
        "room 9" => Room9.new,
        "room 10" => Room10.new,
        "exit" => Exit.new }

    @start_room = Entrance.new
  end

  def opening_room
    @start_room
  end
end