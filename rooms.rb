class Rooms
  @@actions                = ["Go forward", "go left", "go right", "go back"]
  @@show_actions           = true
  @@only_available_actions = true
  @@user_direction         = "east"

  # Spaces to separate the text from the left margin.
  @@tab                    = "      "

  # Clears the console in Unix and Windows systems.
  def clear_screen
    system "clear" or system "cls"
  end

  # Prints actions if @@show_actions is set to true, and gets user input.
  def actions
    if @@show_actions && @@only_available_actions
      create_available_actions_array
      print "#{@@tab}Actions: #{@@available_actions.join(", ").capitalize + "."}\n"
    elsif @@show_actions
      print "#{@@tab}Actions: #{@@actions.join(", ") + "."}\n"
    end
    puts "\n"
    print "#{@@tab}> "

    @user_action = $stdin.gets.chomp
  end

  # Creates the available actions array.
  def create_available_actions_array
    @@available_actions = []

    if @forward_locked == false || @current_room == "room 7"
      @@available_actions << @@actions[0]
    end
    if @left_locked == false || @current_room == "room 7"
      @@available_actions << @@actions[1]
    end
    if @right_locked == false || @current_room == "room 7"
      @@available_actions << @@actions[2]
    end
    if @back_locked == false
      @@available_actions << @@actions[3]
    end
  end

  # When the user introduces a wrong direction.
  def cant_go_there
    clear_screen

    show_room_information
    puts "#{@@tab}You can't go there.\n\n"
    actions
    check_user_action
  end

  # When the door is locked.
  def door_is_locked
    clear_screen

    show_room_information
    puts "#{@@tab}The door seems to be locked.\n\n"
    actions
    check_user_action
  end

  # When the user introduces a wrong action.
  def not_an_action
    clear_screen

    show_room_information
    puts "#{@@tab}I don't understand that action.\n\n"
    actions
    check_user_action
  end

  # Checks the direction the user is facing and the input
  # from the user. If the user changes direction, 
  # and that direction is not locked, it updates the
  # @@user_direction variable, and enters the appropriate room.
  def check_user_action
    if @user_action.downcase == "exit"
      clear_screen
      puts "\nThanks for playing. Hope you enjoyed it!\n\n"
      exit(1)
    end

    map = Map.new
    current_room_index = map.cave_map.index(@current_room)

    # EAST
    if @@user_direction == "east"
      case @user_action.downcase

      # EAST - FORWARD  
      when "go forward"
        next_room_index = current_room_index + 1

        if !@forward_locked
          @@user_direction = "east"

          next_room = map.cave_map[next_room_index]
          map.rooms_list[next_room].enter
        elsif @current_room == "room 7"
          door_is_locked
        else
          cant_go_there
        end  

      # EAST - LEFT
      when "go left"
        left_room_index = current_room_index - 5

        if !@left_locked
          @@user_direction = "north"

          left_room = map.cave_map[left_room_index]
          map.rooms_list[left_room].enter
        else
          cant_go_there
        end

      # EAST - RIGHT
      when "go right"
        right_room_index = current_room_index + 5

        if !@right_locked
          @@user_direction = "south"

          right_room = map.cave_map[right_room_index]
          map.rooms_list[right_room].enter        
        else
          cant_go_there
        end

      # EAST - BACK
      when "go back"
        previous_room_index = current_room_index - 1

        if !@back_locked
          @@user_direction = "west"

          previous_room = map.cave_map[previous_room_index]
          map.rooms_list[previous_room].enter
        else
          cant_go_there
        end

      else
        not_an_action  
      end

    # SOUTH
    elsif @@user_direction == "south"    
      case @user_action.downcase

      # SOUTH - FORWARD
      when "go forward"
        next_room_index = current_room_index + 5

        if !@forward_locked
          @@user_direction = "south"

          next_room = map.cave_map[next_room_index]
          map.rooms_list[next_room].enter
        else
          cant_go_there
        end  

      # SOUTH - LEFT
      when "go left"
        left_room_index = current_room_index + 1

        if !@left_locked && @current_room != "room 7"
          @@user_direction = "east"

          left_room = map.cave_map[left_room_index]
          map.rooms_list[left_room].enter
        elsif @current_room == "room 7"
          door_is_locked
        else
          cant_go_there
        end

      # SOUTH - RIGHT
      when "go right"  
        right_room_index = current_room_index - 1

        if !@right_locked
          @@user_direction = "west"

          right_room = map.cave_map[right_room_index]
          map.rooms_list[right_room].enter
        else
          cant_go_there
        end

      # SOUTH - BACK
      when "go back"
        previous_room_index = current_room_index - 5

        if !@back_locked
          @@user_direction = "north"

          previous_room = map.cave_map[previous_room_index]
          map.rooms_list[previous_room].enter
        else
          cant_go_there
        end
        
      else
        not_an_action
      end

    # NORTH
    elsif @@user_direction == "north"
      case @user_action.downcase

      # NORTH - FORWARD
      when "go forward"
        next_room_index = current_room_index - 5

        if !@forward_locked
          @@user_direction = "north"

          next_room = map.cave_map[next_room_index]
          map.rooms_list[next_room].enter
        else
          cant_go_there
        end  

      # NORTH - LEFT
      when "go left"
        left_room_index = current_room_index - 1

        if !@left_locked
          @@user_direction = "west"

          left_room = map.cave_map[left_room_index]
          map.rooms_list[left_room].enter
        else
          cant_go_there
        end

      # NORTH - RIGHT
      when "go right"  
        right_room_index = current_room_index + 1

        if !@right_locked && @current_room != "room 7"
          @@user_direction = "east"

          right_room = map.cave_map[right_room_index]
          map.rooms_list[right_room].enter
        elsif @current_room == "room 7"
          door_is_locked
        else
          cant_go_there
        end

      # NORTH - BACK
      when "go back"
        previous_room_index = current_room_index + 5

        if !@back_locked
          @@user_direction = "south"

          previous_room = map.cave_map[previous_room_index]
          map.rooms_list[previous_room].enter
        else
          cant_go_there
        end

      else
        not_an_action
      end

    # WEST
    elsif @@user_direction == "west"
      case @user_action.downcase

      # WEST - FORWARD
      when "go forward"
        next_room_index = current_room_index - 1

        if !@forward_locked
          @@user_direction = "west"

          next_room = map.cave_map[next_room_index]
          map.rooms_list[next_room].enter
        else
          cant_go_there
        end 

      # WEST - LEFT
      when "go left"
        left_room_index = current_room_index + 5

        if !@left_locked
          @@user_direction = "south"

          left_room = map.cave_map[left_room_index]
          map.rooms_list[left_room].enter
        else
          cant_go_there
        end

      # WEST - RIGHT
      when "go right"
        right_room_index = current_room_index - 5

        if !@right_locked
          @@user_direction = "north"

          right_room = map.cave_map[right_room_index]
          map.rooms_list[right_room].enter        
        else
          cant_go_there
        end

      # WEST - BACK
      when "go back"
        previous_room_index = current_room_index + 1

        if !@back_locked
          @@user_direction = "east"

          previous_room = map.cave_map[previous_room_index]
          map.rooms_list[previous_room].enter
        else
          cant_go_there
        end

      else
        not_an_action
      end

    else
      puts "Something went wrong."
    end
  end

  # Uses unicode to show arrows for the user direction.
  def arrows
    case @@user_direction
    when "east"  then "\u21c9"
    when "west"  then "\u21c7"
    when "north" then "\u21c8"
    when "south" then "\u21ca"
    end
  end
end

class Entrance < Rooms
  def enter
    @current_room = "entrance"
	  clear_screen
    locked_directions

    show_room_information
    actions
    check_user_action
  end

  def locked_directions
    case @@user_direction
    when "east"
      @left_locked    = true
      @right_locked   = true
      @back_locked    = true
      @forward_locked = false
    when "west"
      @left_locked    = true
      @right_locked   = true
      @back_locked    = false
      @forward_locked = true
    end
  end

  def show_room_information
    puts "\n"
    puts "Entrance\n".center(59)

    puts "
      ##############################################
      #                                            |
      | #{arrows}                                          |
      #                                            |
      ##########     ################     ##########
      #        #     #              #     #        #
      #        #     #              #     #        #
      #        |     #              |     |        #
      ##########     #              |     ##########
      #        #     #              #     #        #
      #        |     #              #     |        #
      #        #     #              #     #        #
      ##############################################
    \n\n"

    if @@user_direction == "east"
      puts "#{@@tab}You are at the entrance of a small construction."
      puts "#{@@tab}A corridor extends to your front."
      puts "#{@@tab}You can see a glass wall at the end.\n\n"
    else
      puts "#{@@tab}You are at the entrance of a small construction.\n\n"
    end
  end
end

class Room1 < Rooms
  def enter
    @current_room = "room 1"
    clear_screen
    locked_directions

    show_room_information
    actions   
    check_user_action
  end

  def locked_directions
    case @@user_direction
    when "east"
      @left_locked    = true
      @right_locked   = false
      @back_locked    = false
      @forward_locked = false
    when "west"
      @left_locked    = false
      @right_locked   = true
      @back_locked    = false
      @forward_locked = false
    when "north"
      @left_locked    = false
      @right_locked   = false
      @back_locked    = false
      @forward_locked = true
    end
  end

  def show_room_information
    puts "\n"
    puts "Corridor\n".center(59)

    puts "
      ##############################################
      #                                            |
      |           #{arrows}                                |
      #                                            |
      ##########     ################     ##########
      #        #     #              #     #        #
      #        #     #              #     #        #
      #        |     #              |     |        #
      ##########     #              |     ##########
      #        #     #              #     #        #
      #        |     #              #     |        #
      #        #     #              #     #        #
      ##############################################
    \n\n"

    if @@user_direction == "east"
      puts "#{@@tab}You can see a corridor to your right.\n\n"
    elsif @@user_direction == "west"
      puts "#{@@tab}You can see a corridor to your left."
      puts "#{@@tab}The entrance to your front.\n\n"
    else
      puts "#{@@tab}You are in the main corridor."
      puts "#{@@tab}The entrance to your left. The glass wall to your right.\n\n"
    end
  end
end

class Room2 < Rooms
  def enter
    @current_room = "room 2"
    clear_screen  
    locked_directions

	  show_room_information
    actions
    check_user_action
  end

  def locked_directions
    case @@user_direction
    when "east"
      @left_locked    = true
      @right_locked   = true
      @back_locked    = false
      @forward_locked = false
    when "west"
      @left_locked    = true
      @right_locked   = true
      @back_locked    = false
      @forward_locked = false
    end
  end

  def show_room_information
    puts "\n"
    puts "Corridor\n".center(59)

    puts "
      ##############################################
      #                                            |
      |                     #{arrows}                      |
      #                                            |
      ##########     ################     ##########
      #        #     #              #     #        #
      #        #     #              #     #        #
      #        |     #              |     |        #
      ##########     #              |     ##########
      #        #     #              #     #        #
      #        |     #              #     |        #
      #        #     #              #     #        #
      ##############################################
    \n\n"

    if @@user_direction == "east"
      puts "#{@@tab}You can see the glass wall at the end.\n\n"
    else
      puts "#{@@tab}You can see the entrance at the end.\n\n"
    end
  end
end

class Room3 < Rooms
	def enter
    @current_room = "room 3"
    clear_screen
    locked_directions

    show_room_information
    actions
    check_user_action
  end

  def locked_directions
    case @@user_direction
    when "east"
      @left_locked    = true
      @right_locked   = false
      @back_locked    = false
      @forward_locked = false
    when "west"
      @left_locked    = false
      @right_locked   = true
      @back_locked    = false
      @forward_locked = false
    when "north"
      @left_locked    = false
      @right_locked   = false
      @back_locked    = false
      @forward_locked = true
    end
  end

  def show_room_information
    puts "\n"
    puts "Corridor\n".center(59)
    
    puts "
      ##############################################
      #                                            |
      |                                #{arrows}           |
      #                                            |
      ##########     ################     ##########
      #        #     #              #     #        #
      #        #     #              #     #        #
      #        |     #              |     |        #
      ##########     #              |     ##########
      #        #     #              #     #        #
      #        |     #              #     |        #
      #        #     #              #     #        #
      ##############################################
    \n\n"

    if @@user_direction == "east"
      puts "#{@@tab}You can see a corridor to your right."
      puts "#{@@tab}The glass wall to your front.\n\n"
    elsif @@user_direction == "west"
      puts "#{@@tab}You can see a corridor to your left."
      puts "#{@@tab}The entrance to your front.\n\n"
    elsif @@user_direction == "north"
      puts "#{@@tab}You are in the main corridor."
      puts "#{@@tab}The entrance to your left. The glass wall to your right.\n\n"
    else
      puts "#{@@tab}You are in the main corridor."
      puts "#{@@tab}You can see the entrance at the end.\n\n"
    end
  end
end

class Room4 < Rooms
  def enter
    @current_room = "room 4"
    clear_screen
    locked_directions

    show_room_information
    actions
    check_user_action
  end

  def locked_directions
    case @@user_direction
    when "east"
      @left_locked    = true
      @right_locked   = true
      @back_locked    = false
      @forward_locked = true
    end
  end

  def show_room_information
    puts "\n"
    puts "Glass Wall Room\n".center(59)

    puts "
      ##############################################
      #                                            |      @@@
      |                                        #{arrows}   |     @@o@@
      #                                            |      @@@
      ##########     ################     ##########
      #        #     #              #     #        #
      #        #     #              #     #        #
      #        |     #              |     |        #
      ##########     #              |     ##########
      #        #     #              #     #        #
      #        |     #              #     |        #
      #        #     #              #     #        #
      ##############################################
    \n\n"

    puts "#{@@tab}There is a wall-sized window in front of you."
    puts "#{@@tab}You can see a big cherry tree, its leaves and flowers"
    puts "#{@@tab}moving gently in the slight breeze.\n\n"
  end
end

# Initially, this room was supposed to be locked.
class Locked < Rooms
  def enter
    @current_room = "locked"
    clear_screen
    locked_directions

	  show_room_information
    actions
    check_user_action
  end

  def locked_directions
    case @@user_direction
    when "west"
      @left_locked    = true
      @right_locked   = true
      @back_locked    = false
      @forward_locked = true
    end
  end

  def show_room_information
    puts "\n"
    puts "Room\n".center(59)

    puts "
      ##############################################
      #                                            |
      |                                            |
      #                                            |
      ##########     ################     ##########
      #        #     #              #     #        #
      #        #     #              #     #        #
      #     #{arrows} /      #              |     |        #
      ##########     #              |     ##########
      #        #     #              #     #        #
      #        |     #              #     |        #
      #        #     #              #     #        #
      ##############################################
    \n\n"

    puts "#{@@tab}An empty room."
    puts "#{@@tab}Not much to see here.\n\n"
  end
end

class Room5 < Rooms
  def enter
    @current_room = "room 5"
    clear_screen
    locked_directions

    show_room_information
    actions
    check_user_action
  end

  def locked_directions
    case @@user_direction
    when "east"
      @left_locked    = false
      @right_locked   = false
      @back_locked    = false
      @forward_locked = true
    when "south"
      @left_locked    = true
      @right_locked   = false
      @back_locked    = false
      @forward_locked = false
    when "north"
      @left_locked    = false
      @right_locked   = true
      @back_locked    = false
      @forward_locked = false
    end
  end

  def show_room_information
    puts "\n"
    puts "Corridor\n".center(59)

    puts "
      ##############################################
      #                                            |
      |                                            |
      #                                            |
      ##########     ################     ##########
      #        #     #              #     #        #
      #        #     #              #     #        #
      #        |  #{arrows}  #              |     |        #
      ##########     #              |     ##########
      #        #     #              #     #        #
      #        |     #              #     |        #
      #        #     #              #     #        #
      ##############################################
    \n\n"

    if @@user_direction == "south"
      puts "#{@@tab}There's a room to your right."
      puts "#{@@tab}The corridor continues a little to your front.\n\n"
    elsif @@user_direction == "north"
      puts "#{@@tab}There's a room to your left."
      puts "#{@@tab}To your front you can get to the main corridor.\n\n"
    else
      puts "#{@@tab}To your left you can get to the main corridor."
      puts "#{@@tab}To your right the corridor continues a little.\n\n"
    end
  end
end

class Room6 < Rooms
  def enter
    @current_room = "room 6"
    clear_screen
    locked_directions

    show_room_information
    actions
    check_user_action
  end

  def locked_directions
    case @@user_direction
    when "west"
      @left_locked    = true
      @right_locked   = true
      @back_locked    = false
      @forward_locked = true
    end
  end

  def show_room_information
    puts "\n"
    puts "Room\n".center(59)

    puts "
      ##############################################
      #                                            |
      |                                            |
      #                                            |
      ##########     ################     ##########
      #        #     #              #     #        #
      #        #     #              #     #        #
      #        |     #           #{arrows} /      |        #
      ##########     #              |     ##########
      #        #     #              #     #        #
      #        |     #              #     |        #
      #        #     #              #     #        #
      ##############################################
    \n\n"

    puts "#{@@tab}A big and empty room."
    puts "#{@@tab}Not much to see here.\n\n"
  end
end

class Room7 < Rooms
  def enter
    @current_room = "room 7"
    clear_screen
    locked_directions
    
    show_room_information
    actions
    check_user_action
  end

  def locked_directions
    case @@user_direction
    when "east"
      @left_locked    = false
      @right_locked   = false
      @back_locked    = false
      @forward_locked = true
    when "south"
      @left_locked    = true
      @right_locked   = false
      @back_locked    = false
      @forward_locked = false
    when "north"
      @left_locked    = false
      @right_locked   = true
      @back_locked    = false
      @forward_locked = false
    end
  end

  def show_room_information
    puts "\n"
    puts "Corridor\n".center(59)

    puts "
      ##############################################
      #                                            |
      |                                            |
      #                                            |
      ##########     ################     ##########
      #        #     #              #     #        #
      #        #     #              #     #        #
      #        |     #              |  #{arrows}  |        #
      ##########     #              |     ##########
      #        #     #              #     #        #
      #        |     #              #     |        #
      #        #     #              #     #        #
      ##############################################
    \n\n"
  
    if @@user_direction == "south"
      puts "#{@@tab}There are rooms to your left and right."
      puts "#{@@tab}The corridor continues a little to your front.\n\n"
    elsif @@user_direction == "north"
      puts "#{@@tab}There are rooms to your left and right."
      puts "#{@@tab}To your front you can get to the main corridor.\n\n"
    else
      puts "#{@@tab}To your left you can get to the main corridor."
      puts "#{@@tab}To your right the corridor continues a little.\n\n"
    end
  end
end

class Room8 < Rooms
  def enter
    @current_room = "room 8"
    clear_screen
    locked_directions
    
    show_room_information
    actions
    check_user_action
  end

  def locked_directions
    case @@user_direction
    when "west"
      @left_locked    = true
      @right_locked   = true
      @back_locked    = false
      @forward_locked = true
    end
  end

  def show_room_information
    puts "\n"
    puts "Room\n".center(59)

    puts "
      ##############################################
      #                                            |
      |                                            |
      #                                            |
      ##########     ################     ##########
      #        #     #              #     #        #
      #        #     #              #     #        #
      #        |     #              |     |        #
      ##########     #              |     ##########
      #        #     #              #     #        #
      #     #{arrows} /      #              #     |        #
      #        #     #              #     #        #
      ##############################################
    \n\n"

    puts "#{@@tab}An empty room."
    puts "#{@@tab}Not much to see here.\n\n"
  end
end

class Room9 < Rooms
  def enter
    @current_room = "room 9"
    clear_screen
    locked_directions
    
    show_room_information
    actions
    check_user_action
  end

  def locked_directions
    case @@user_direction
    when "east"
      @left_locked    = false
      @right_locked   = true
      @back_locked    = false
      @forward_locked = true
    when "south"
      @left_locked    = true
      @right_locked   = false
      @back_locked    = false
      @forward_locked = true
    end
  end

  def show_room_information
    puts "\n"
    puts "Corridor\n".center(59)

    puts "
      ##############################################
      #                                            |
      |                                            |
      #                                            |
      ##########     ################     ##########
      #        #     #              #     #        #
      #        #     #              #     #        #
      #        |     #              |     |        #
      ##########     #              |     ##########
      #        #     #              #     #        #
      #        |  #{arrows}  #              #     |        #
      #        #     #              #     #        #
      ##############################################
    \n\n"

    if @@user_direction == "south"
      puts "#{@@tab}The corridor ends here."
      puts "#{@@tab}There's a room to your right.\n\n"
    else
      puts "#{@@tab}To your left you can get to the main corridor.\n\n"
    end
  end
end

class Room10 < Rooms
  def enter
    @current_room = "room 10"
    clear_screen
    locked_directions
    
    show_room_information
    actions
    check_user_action
  end

  def locked_directions
    case @@user_direction
    when "west"
      @left_locked    = true
      @right_locked   = false
      @back_locked    = false
      @forward_locked = true
    when "south"
      @left_locked    = false
      @right_locked   = true
      @back_locked    = false
      @forward_locked = true
    end
  end

  def show_room_information
    puts "\n"
    puts "Corridor\n".center(59)

    puts "
      ##############################################
      #                                            |
      |                                            |
      #                                            |
      ##########     ################     ##########
      #        #     #              #     #        #
      #        #     #              #     #        #
      #        |     #              |     |        #
      ##########     #              |     ##########
      #        #     #              #     #        #
      #        |     #              #  #{arrows}  |        #
      #        #     #              #     #        #
      ##############################################
    \n\n"

    if @@user_direction == "south"
      puts "#{@@tab}The corridor ends here."
      puts "#{@@tab}There's a room to your left.\n\n"
    else
      puts "#{@@tab}To your right you can get to the main corridor.\n\n"
    end
  end
end

class Exit < Rooms
  def enter
    @current_room = "exit"
    clear_screen
    locked_directions

	  show_room_information
    actions
    check_user_action
  end

  def locked_directions
    case @@user_direction
    when "east"
      @left_locked    = true
      @right_locked   = true
      @back_locked    = false
      @forward_locked = true
    end
  end

  def show_room_information
    puts "\n"
    puts "Room\n".center(59)

    puts "
      ##############################################
      #                                            |
      |                                            |
      #                                            |
      ##########     ################     ##########
      #        #     #              #     #        #
      #        #     #              #     #        #
      #        |     #              |     |        #
      ##########     #              |     ##########
      #        #     #              #     #        #
      #        |     #              #      / #{arrows}     #
      #        #     #              #     #        #
      ##############################################
    \n\n"

    puts "#{@@tab}An empty room."
    puts "#{@@tab}Not much to see here.\n\n"
  end
end