module TheLift
  class Lift
    # initialise going up
    # maximum capacity -> maximum people allowed in the lift
    # people count -> people in the lift
    # lift should know current floor
    # knows if it's going up or down
    attr_reader :max_capacity, :current_floor, :floor_history, :people_count

    def initialize(max_capacity:)
      @max_capacity = max_capacity
      @people_count = 0
      @current_floor = 0
      @floor_history = [0]
    end

    def move(floor:)
      @current_floor = floor
      @floor_history << current_floor
    end

    def space_left
      max_capacity - people_count
    end
  end
end
