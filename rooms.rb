class Rooms

  @@actions = ["Go forward", "go left", "go right", "go back"]
  @@user_direction = "east"
  @@show_direction = false
  @@tab = "      " # Add spaces to separate the text from the left margin.

  # Clears the console in Unix and Windows systems.
  def clear_screen
    system "clear" or system "cls"
  end

  # Prints actions and gets user input.
  def actions
    print "#{@@tab}Actions: #{@@actions.join(", ") + "."}\n\n"
    print "#{@@tab}> "

    @user_action = $stdin.gets.chomp
  end

  # When the user introduces a wrong action.
  def not_an_action
    clear_screen

    show_room_information

    puts "#{@@tab}I don't understand that action.\n\n"

    actions

    check_user_action
  end

  # Checks the input from the user and does the appropriate action.
  def check_user_action

    map = Map.new
    current_room_index = map.cave_map.index(@current_room)

    # EAST
    if @@user_direction == "east"

      case @user_action.downcase
      when "go forward"

        next_room_index = current_room_index + 1

        if !@forward_locked
          @@user_direction = "east"

          next_room = map.cave_map[next_room_index]
          map.rooms_list[next_room].enter
        else
          clear_screen

          show_room_information

          puts "#{@@tab}You can't go there.\n\n"

          actions
          check_user_action
        end  

      when "go left"

        left_room_index = current_room_index - 5

        if !@left_locked
          @@user_direction = "north"

          left_room = map.cave_map[left_room_index]
          map.rooms_list[left_room].enter
        else
          clear_screen

          show_room_information

          puts "#{@@tab}You can't go there.\n\n"

          actions
          check_user_action
        end

      when "go right"

        right_room_index = current_room_index + 5

        if !@right_locked
          @@user_direction = "south"

          right_room = map.cave_map[right_room_index]
          map.rooms_list[right_room].enter        
        else
          clear_screen

          show_room_information

          puts "#{@@tab}You can't go there.\n\n"

          actions
          check_user_action
        end

      when "go back"

        previous_room_index = current_room_index - 1

        if !@back_locked
          @@user_direction = "west"

          previous_room = map.cave_map[previous_room_index]
          map.rooms_list[previous_room].enter
        else
          clear_screen

          show_room_information

          puts "#{@@tab}You can't go there.\n\n"

          actions
          check_user_action
        end

      else

        not_an_action  

      end

    # SOUTH
    elsif @@user_direction == "south"
      
      case @user_action.downcase
      when "go forward"

        next_room_index = current_room_index + 5

        if !@forward_locked
          @@user_direction = "south"

          next_room = map.cave_map[next_room_index]
          map.rooms_list[next_room].enter
        else
          clear_screen

          show_room_information

          puts "#{@@tab}You can't go there.\n\n"

          actions
          check_user_action
        end  

      when "go left"

        left_room_index = current_room_index + 1

        if !@left_locked && @current_room != "room 7"
          @@user_direction = "east"

          left_room = map.cave_map[left_room_index]
          map.rooms_list[left_room].enter
        elsif @current_room == "room 7"
          clear_screen

          show_room_information

          puts "#{@@tab}The door seems to be locked.\n\n"

          actions
          check_user_action
        else
          clear_screen

          show_room_information

          puts "#{@@tab}You can't go there.\n\n"

          actions
          check_user_action
        end

      when "go right"  

        right_room_index = current_room_index - 1

        if !@right_locked
          @@user_direction = "west"

          right_room = map.cave_map[right_room_index]
          map.rooms_list[right_room].enter
        else
          clear_screen

          show_room_information

          puts "#{@@tab}You can't go there.\n\n"

          actions
          check_user_action
        end

      when "go back"

        previous_room_index = current_room_index - 5

        if !@back_locked
          @@user_direction = "north"

          previous_room = map.cave_map[previous_room_index]
          map.rooms_list[previous_room].enter
        else
          clear_screen

          show_room_information

          puts "#{@@tab}You can't go there.\n\n"

          actions
          check_user_action
        end

      else

        not_an_action

      end

    # NORTH
    elsif @@user_direction == "north"

      case @user_action.downcase
      when "go forward"

        next_room_index = current_room_index - 5

        if !@forward_locked
          @@user_direction = "north"

          next_room = map.cave_map[next_room_index]
          map.rooms_list[next_room].enter
        else
          clear_screen

          show_room_information

          puts "#{@@tab}You can't go there.\n\n"

          actions
          check_user_action
        end  

      when "go left"

        left_room_index = current_room_index - 1

        if !@left_locked
          @@user_direction = "west"

          left_room = map.cave_map[left_room_index]
          map.rooms_list[left_room].enter
        else
          clear_screen

          show_room_information

          puts "#{@@tab}You can't go there.\n\n"

          actions
          check_user_action
        end

      when "go right"  

        right_room_index = current_room_index + 1

        if !@right_locked && @current_room != "room 7"
          @@user_direction = "east"

          right_room = map.cave_map[right_room_index]
          map.rooms_list[right_room].enter
        elsif @current_room == "room 7"
          clear_screen

          show_room_information

          puts "#{@@tab}The door seems to be locked.\n\n"

          actions
          check_user_action
        else
          clear_screen

          show_room_information

          puts "#{@@tab}You can't go there.\n\n"

          actions
          check_user_action
        end

      when "go back"

        previous_room_index = current_room_index + 5

        if !@back_locked
          @@user_direction = "south"

          previous_room = map.cave_map[previous_room_index]
          map.rooms_list[previous_room].enter
        else
          clear_screen

          show_room_information

          puts "#{@@tab}You can't go there.\n\n"

          actions
          check_user_action
        end

      else

        not_an_action

      end

    # WEST
    elsif @@user_direction == "west"

      case @user_action.downcase
      when "go forward"

        next_room_index = current_room_index - 1

        if !@forward_locked
          @@user_direction = "west"

          next_room = map.cave_map[next_room_index]
          map.rooms_list[next_room].enter
        else
          clear_screen

          show_room_information

          puts "#{@@tab}You can't go there.\n\n"

          actions
          check_user_action
        end  

      when "go left"

        left_room_index = current_room_index + 5

        if !@left_locked
          @@user_direction = "south"

          left_room = map.cave_map[left_room_index]
          map.rooms_list[left_room].enter
        else
          clear_screen

          show_room_information

          puts "#{@@tab}You can't go there.\n\n"

          actions
          check_user_action
        end

      when "go right"

        right_room_index = current_room_index - 5

        if !@right_locked
          @@user_direction = "north"

          right_room = map.cave_map[right_room_index]
          map.rooms_list[right_room].enter        
        else
          clear_screen

          show_room_information

          puts "#{@@tab}You can't go there.\n\n"

          actions
          check_user_action
        end

      when "go back"

        previous_room_index = current_room_index + 1

        if !@back_locked
          @@user_direction = "east"

          previous_room = map.cave_map[previous_room_index]
          map.rooms_list[previous_room].enter
        else
          clear_screen

          show_room_information

          puts "#{@@tab}You can't go there.\n\n"

          actions
          check_user_action
        end

      else

        not_an_action

      end

    else

      puts "Something went wrong."

    end
  end

  # Shows the user direction.
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
		clear_screen

    @current_room = "entrance"

    locked_directions

    show_room_information

    actions

    check_user_action
	end

  def locked_directions
    case @@user_direction
    when "east"
      @left_locked = true
      @right_locked = true
      @back_locked = true
      @forward_locked = false
    when "west"
      @left_locked = true
      @right_locked = true
      @back_locked = false
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
      ##########     #              #     ##########
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

    puts "#{@@tab}Direction: #{@@user_direction}\n\n" if @@show_direction
  end
end

class Room1 < Rooms

	def enter
    clear_screen

    @current_room = "room 1"

    locked_directions

    show_room_information

    actions   

    check_user_action
	end

  def locked_directions
    case @@user_direction
    when "east"
      @left_locked = true
      @right_locked = false
      @back_locked = false
      @forward_locked = false
    when "west"
      @left_locked = false
      @right_locked = true
      @forward_locked = false
      @back_locked = false
    when "north"
      @left_locked = false
      @right_locked = false
      @forward_locked = true
      @back_locked = false
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
      ##########     #              #     ##########
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

    puts "#{@@tab}Direction: #{@@user_direction}\n\n" if @@show_direction
  end
end

class Room2 < Rooms

	def enter
    clear_screen
    
    @current_room = "room 2"

    locked_directions

		show_room_information

    actions

    check_user_action
	end

  def locked_directions
    case @@user_direction
    when "east"
      @left_locked = true
      @right_locked = true
      @back_locked = false
      @forward_locked = false
    when "west"
      @left_locked = true
      @right_locked = true
      @back_locked = false
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
      ##########     #              #     ##########
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

    puts "#{@@tab}Direction: #{@@user_direction}\n\n" if @@show_direction
  end
end

class Room3 < Rooms

	def enter
    clear_screen

    @current_room = "room 3"

    locked_directions

    show_room_information

    actions

    check_user_action
	end

  def locked_directions
    case @@user_direction
    when "east"
      @left_locked = true
      @right_locked = false
      @back_locked = false
      @forward_locked = false
    when "west"
      @left_locked = false
      @right_locked = true
      @forward_locked = false
      @back_locked = false
    when "north"
      @left_locked = false
      @right_locked = false
      @forward_locked = true
      @back_locked = false
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
      ##########     #              #     ##########
      #        #     #              #     #        #
      #        |     #              #     |        #
      #        #     #              #     #        #
      ##############################################
    \n\n"

    if @@user_direction == "east"
      puts "#{@@tab}You can see a corridor to your right,"
      puts "#{@@tab}the glass wall to your front.\n\n"
    elsif @@user_direction == "west"
      puts "#{@@tab}You can see a corridor to your left,"
      puts "#{@@tab}the entrance to your front.\n\n"
    elsif @@user_direction == "north"
      puts "#{@@tab}You are in the main corridor."
      puts "#{@@tab}The entrance to your left."
      puts "#{@@tab}The glass wall to your right.\n\n"
    else
      puts "#{@@tab}You are in the main corridor."
      puts "#{@@tab}You can see the entrance at the end.\n\n"
    end

    puts "#{@@tab}Direction: #{@@user_direction}\n\n" if @@show_direction
  end
end

class Room4 < Rooms

	def enter
    clear_screen

    @current_room = "room 4"

    locked_directions

    show_room_information

    actions

    check_user_action
	end

  def locked_directions
    case @@user_direction
    when "east"
      @left_locked = true
      @right_locked = true
      @back_locked = false
      @forward_locked = true
    end
  end

  def show_room_information
    puts "\n"
    puts "Glass Wall Room\n".center(59)

    puts "
      ##############################################
      #                                            |
      |                                        #{arrows}   |
      #                                            |
      ##########     ################     ##########
      #        #     #              #     #        #
      #        #     #              #     #        #
      #        |     #              |     |        #
      ##########     #              #     ##########
      #        #     #              #     #        #
      #        |     #              #     |        #
      #        #     #              #     #        #
      ##############################################
    \n\n"

    puts "#{@@tab}There is a wall-sized window in front of you."
    puts "#{@@tab}You can see a big cherry tree, its leaves and flowers"
    puts "#{@@tab}moving gently in the slight breeze.\n\n"

    puts "#{@@tab}Direction: #{@@user_direction}\n\n" if @@show_direction
  end
end

class Locked < Rooms

	def enter
    clear_screen

    @current_room = "locked"

    locked_directions

		show_room_information

    actions

    check_user_action
	end

  def locked_directions
    case @@user_direction
    when "west"
      @left_locked = true
      @right_locked = true
      @back_locked = false
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
      ##########     #              #     ##########
      #        #     #              #     #        #
      #        |     #              #     |        #
      #        #     #              #     #        #
      ##############################################
    \n\n"

    puts "#{@@tab}Not much to see in this room.\n\n"

    puts "#{@@tab}Direction: #{@@user_direction}\n\n" if @@show_direction
  end
end

class Room5 < Rooms

  def enter
    clear_screen

    @current_room = "room 5"

    locked_directions

    show_room_information

    actions

    check_user_action
  end

  def locked_directions
    case @@user_direction
    when "east"
      @left_locked = false
      @right_locked = false
      @back_locked = false
      @forward_locked = true
    when "south"
      @left_locked = true
      @right_locked = false
      @back_locked = false
      @forward_locked = false
    when "north"
      @left_locked = false
      @right_locked = true
      @back_locked = false
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
      ##########     #              #     ##########
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
      puts "#{@@tab}To your right the corridor continues a little,"
      puts "#{@@tab}and there's another door.\n\n"
    end

    puts "#{@@tab}Direction: #{@@user_direction}\n\n" if @@show_direction
  end
end

class Room6 < Rooms

  def enter
    clear_screen

    @current_room = "room 6"

    locked_directions

    show_room_information

    actions

    check_user_action
  end

  def locked_directions
    case @@user_direction
    when "west"
      @left_locked = true
      @right_locked = true
      @back_locked = false
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
      ##########     #              #     ##########
      #        #     #              #     #        #
      #        |     #              #     |        #
      #        #     #              #     #        #
      ##############################################
    \n\n"

    puts "#{@@tab}Not much to see in this room.\n\n"

    puts "#{@@tab}Direction: #{@@user_direction}\n\n" if @@show_direction
  end
end

class Room7 < Rooms

  def enter
    clear_screen

    @current_room = "room 7"

    locked_directions
    
    show_room_information

    actions

    check_user_action
  end

  def locked_directions
    case @@user_direction
    when "east"
      @left_locked = false
      @right_locked = false
      @back_locked = false
      @forward_locked = true
    when "south"
      @left_locked = true
      @right_locked = false
      @back_locked = false
      @forward_locked = false
    when "north"
      @left_locked = false
      @right_locked = true
      @back_locked = false
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
      ##########     #              #     ##########
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
      puts "#{@@tab}To your right the corridor continues a little,"
      puts "#{@@tab}and there's another door.\n\n"
    end

    puts "#{@@tab}Direction: #{@@user_direction}\n\n" if @@show_direction
  end
end

class Room8 < Rooms

  def enter
    clear_screen

    @current_room = "room 8"

    locked_directions
    
    show_room_information

    actions

    check_user_action
  end

  def locked_directions
    case @@user_direction
    when "west"
      @left_locked = true
      @right_locked = true
      @back_locked = false
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
      ##########     #              #     ##########
      #        #     #              #     #        #
      #     #{arrows} /      #              #     |        #
      #        #     #              #     #        #
      ##############################################
    \n\n"

    puts "#{@@tab}Not much to see in this room.\n\n"

    puts "#{@@tab}Direction: #{@@user_direction}\n\n" if @@show_direction
  end
end

class Room9 < Rooms

  def enter
    clear_screen

    @current_room = "room 9"

    locked_directions
    
    show_room_information

    actions

    check_user_action
  end

  def locked_directions
    case @@user_direction
    when "east"
      @left_locked = false
      @right_locked = true
      @back_locked = false
      @forward_locked = true
    when "south"
      @left_locked = true
      @right_locked = false
      @back_locked = false
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
      ##########     #              #     ##########
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

    puts "#{@@tab}Direction: #{@@user_direction}\n\n" if @@show_direction
  end
end

class Room10 < Rooms

  def enter
    clear_screen

    @current_room = "room 10"

    locked_directions
    
    show_room_information

    actions

    check_user_action
  end

  def locked_directions
    case @@user_direction
    when "west"
      @left_locked = true
      @right_locked = false
      @back_locked = false
      @forward_locked = true
    when "south"
      @left_locked = false
      @right_locked = true
      @back_locked = false
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
      ##########     #              #     ##########
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

    puts "#{@@tab}Direction: #{@@user_direction}\n\n" if @@show_direction
  end
end

class Exit < Rooms

	def enter
    clear_screen

    @current_room = "exit"

    locked_directions

		show_room_information

    actions

    check_user_action
	end

  def locked_directions
    case @@user_direction
    when "east"
      @left_locked = true
      @right_locked = true
      @back_locked = false
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
      ##########     #              #     ##########
      #        #     #              #     #        #
      #        |     #              #      / #{arrows}     #
      #        #     #              #     #        #
      ##############################################
    \n\n"

    puts "#{@@tab}Not much to see in this room.\n\n"

    puts "#{@@tab}Direction: #{@@user_direction}\n\n" if @@show_direction
  end
end