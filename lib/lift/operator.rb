require "forwardable"
require "pry-byebug"

module TheLift
  class Operator
    extend Forwardable

    attr_reader :queues, :lift, :people_in_lift

    delegate [:current_floor, :space_left, :move] => :lift

    def initialize(queues:, max_capacity:)
      @queues = queues
      @lift = Lift.new(max_capacity: max_capacity)
      @people_in_lift = []
    end

    # def move(current_floor: current_floor)
    #   lift.move(current_floor)
    #   onboarding
    # end

    def onboarding(current_floor: current_floor)
      #for each people in the lift, if their destination floor == current_floor -> drop from people_in_lift
      #for each people on the current floor, we check if space_left > 0 then we board space_left people in the lift and drop from the queues
      people_out
      lift.space_left.times { people_in }
    end

    def people_in
      # binding.pry
      @people_in_lift << queues[current_floor].delete_at(0) if queues[lift.current_floor].any?
    end

    def people_out
      # binding.pry
      @people_in_lift.reject! { |e| e == lift.current_floor }
    end
  end
end
