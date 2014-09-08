class Dungeon
  attr_accessor :player

  def initialize(player_name)
    @player = Player.new(player_name)
    @rooms = []
    @event = []###############################################
  end

  Player = Struct.new(:name, :location)
  Room = Struct.new(:reference, :name, :description, :connections)
  Event = Struct.new(:reference, :name, :description, :connections)###############################################

  def add_room(reference, name, description, connections)
    @rooms << Room.new(reference, name, description, connections)
  end

  def add_event(reference, name, description, connections)
    @event << Event.new(reference, name, description, connections)
  end

  def start(location, choice)####location=choice#############################
    @player.location = location
    @player.choice = choice#############################
    show_current_description
    show_current_descript
  end





  def show_current_description
    puts find_room_in_dungeon(@player.location).full_description
  end

  def find_room_in_direction(direction)
    find_room_in_dungeon(@player.location).connections[direction]
  end

  def find_room_in_dungeon(reference)
    @rooms.detect { |room| room.reference == reference }
  end

  def go(direction)
    puts "You go " + direction.to_s
    @player.location = find_room_in_direction(direction)
    show_current_description
    event.do(path)
  end







  def show_current_descript#############################
    puts find_event_in_dungeon(@player.choice).descript#############################
  end



  def find_event_in_path(path)#direction = path#############################
    find_event_in_dungeon(@player.location).connections[path]
  end

  def find_event_in_dungeon(reference)
    @event.detect { |event| event.reference == reference }
  end

  def do(path)
    puts "You go " + path.to_s
    @player.choice = find_event_in_path(path)
    show_current_descript
  end

  class Player
    attr_accessor :name, :location, :choice

    def initialize(name)
      @name = name
    end
  end






  class Player
    attr_accessor :name, :location

    def initialize(name)
      @name = name
    end
  end




  class Room
    attr_accessor :reference, :name, :description, :connections

    def initialize(reference, name, description, connections)
      @reference = reference
      @name = name
      @description = description
      @connections = connections
    end

    def full_description
      puts "You " + @description
      # event.descript
    end
  end


  class Event
    attr_accessor :reference, :name, :description, :connections

    def initialize(reference, name, description, connections)
      @reference = reference
      @name = name
      @description = description
      @connections = connections
    end

    def descript
      puts "***************#{@description}"
      while @description != :newdirection
        puts "You " + @description
      end
    end
 end

end



my_dungeon = Dungeon.new("fredd Bloggs")

my_dungeon.add_room(:largecave, "Large Cave", "enter a large cavernous cave", { :north => :mountains, :west => :smallcave, :south => :forest})
my_dungeon.add_room(:smallcave, "Small Cave", "enter a small, claustrophobic cave", { :east => :largecave, :north => :largefield, :west => :path, :south => :smallfield})
my_dungeon.add_room(:largefield, "Large Field", "come upon a large, open field", {:west => :cottage, :south => :forest, :east => :mountains})
my_dungeon.add_room(:forest, "Forest", "find yourself in a dark, wooded forest", {:west => :smallfield, :north => :largecave})
my_dungeon.add_room(:cottage, "Cottage", "come upon a pleasant little cottage", {:south => :path, :east => :largefield})
my_dungeon.add_room(:path, "Path", "walk down a quiet, meandering path", {:north => :cottage, :east => :smallcave, :south => :castle})
my_dungeon.add_room(:castle, "Castle", "find yourself in a dark, foreboding castle", {:north => :path, :east => :smallfield})
my_dungeon.add_room(:smallfield, "Small Field", "come out into a small, flower-covered field", {:west => :castle, :north => :smallcave, :east => :forest})
my_dungeon.add_room(:mountains, "The Mountains", "trudge slowly through a series of steep, snow-covered mountains", {:west => :largefield, :south => :largecave})


my_dungeon.add_event(:troll, "Troll", "come upon a mean little troll who will not let you proceed", { :fight => :rock, :flee => :run, :hide => :dig})
my_dungeon.add_event(:rat, "Rat", "see a rat", {:fight => :rock, :flee => :troll, :leave => :newdirection})
my_dungeon.add_event(:rock, "Rock", "pick up a rock and throw it", {:leave => :newdirection, :explore => :dig, :flee => :run})
my_dungeon.add_event(:treasure, "Treasure", "find a treasure", {:leave => :newdirection})
my_dungeon.add_event(:run, "Run Away", "run away", {:explore => :troll, :leave => :newdirection})
my_dungeon.add_event(:dig, "Dig a Tunnel", "dig a tunnel", {:explore => :treasure, :leave => :newdirection})
my_dungeon.add_event(:newdirection, "New Direction", "go another direction", {:west => :castle, :north => :smallcave, :east => :forest})



puts "Welcome to Dungeon Adventure! What shall I call you?"
player_name = gets.chomp
puts "Hello, #{player_name}!"
my_dungeon.start(:forest, :rat) #:rat


while true do
  begin
    puts "Which direction (north, south, east, west) would you like to venture?"
    puts "(Type exit to quit the program)"
    dir = gets.chomp.to_sym
    if dir == :exit
      abort("Thank you for playing, #{player_name}! Goodbye.")
    end

    my_dungeon.go(dir)
  rescue
    puts "You cannot go in that direction. Try another route!"
  end
end



#############################
#location = choice
#room = event
#direction = path
#go = do
#description = descript



##another class and several more methods
# place at different locations, pick up, and drop off at other locations
#create a loop that uses gets method to retrieve instructions from player and go there.
# use chomp and .to_sym
# type exit to leave the game
#add rats and trolls
# get hungry, stab a rat
#create classes for new objects
