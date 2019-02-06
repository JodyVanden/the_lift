require "forwardable"
require "pry-byebug"

module TheLift
  class Operator
    extend Forwardable

    attr_reader :queues, :lift, :people_in_lift, :lift_stops

    delegate [:current_floor, :space_left, :move, :floor_history] => :lift

    def initialize(queues:, max_capacity:)
      @queues = queues
      @lift = Lift.new(max_capacity: max_capacity)
      @lift_stops = []
      queues_init(queues)
      @people_in_lift = []
      # next_floor
    end

    def queues_init(queues)
      queues.each_with_index do |queue, floor|
        if queue.any?
          @lift_stops << floor
          queue.each { |person| @lift_stops << person }
        end
      end
      @lift_stops.uniq!
    end

    def next_floor
      while lift_stops.any? || people_in_lift.any?
        if lift.space_left > 0 && !lift_stops.first.nil?
          #go to the nearest floor in lift_stops
          onboarding(current_floor: lift_stops.first)
        elsif lift.space_left == 0
          #go to the nearest floor of people in the lift
          onboarding(current_floor: people_in_lift.first)
        elsif !people_in_lift.any?
          #go to the nearest floor of people in the lift
          onboarding(current_floor: people_in_lift.first)
        end
      end
      lift.move(floor: 0)
    end

    def onboarding(current_floor: current_floor)
      #for each people in the lift, if their destination floor == current_floor -> drop from people_in_lift
      #for each people on the current floor, we check if space_left > 0 then we board space_left people in the lift and drop from the queues
      lift.move(floor: current_floor)
      people_out if space_left != 5
      people_waiting_floor = queues[current_floor].size || 0
      runtime = people_waiting_floor > lift.space_left ? lift.space_left : queues[current_floor].size
      runtime.times { people_in }
    end

    def people_in
      @people_in_lift << queues[current_floor].delete_at(0) if queues
      @lift_stops.reject! { |e| e == lift.current_floor }
      @lift_stops + people_in_lift
      @lift_stops.uniq!
      @lift_stops.sort!
      @lift.people_count += 1
    end

    def people_out
      @people_in_lift.reject! { |e| e == lift.current_floor }
      @lift_stops.reject! { |e| e == lift.current_floor }
      @lift.people_count -= 1
    end
  end
end
