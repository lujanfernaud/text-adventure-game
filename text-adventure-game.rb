# Text Adventure Game
# Learn Ruby The Hard Way - Exercise 45
# http://learnrubythehardway.org/book/ex45.html

require './map.rb'

class Engine
  def initialize(game_map)
    @game_map = game_map
  end

  def play
    @game_map.opening_room.enter
  end
end

map = Map.new
game = Engine.new(map)
game.play