RSpec.describe TheLift::Operator do
  queues = [[], [], [5, 5, 5], [], [], [], []]
  subject { TheLift::Operator.new(queues: queues, max_capacity: 5) }
  describe "lift infos" do
    it "should initialize the operator" do
      expect(subject.queues).to eq(queues)
      expect(subject.current_floor).to eq(0)
      expect(subject.space_left).to eq(5)
    end

    it "should know space left in the lift" do
      subject.onboarding
      expect(subject.queues).to eq(queues)
      expect(subject.current_floor).to eq(0)
      expect(subject.space_left).to eq(5)
    end

    it "should take people in the lift if at the current floor" do
      subject.move(floor: 2)
      subject.onboarding
      expect(subject.people_in_lift).to eq([5, 5, 5])
    end

    it "should take people out of the lift if at the current floor" do
      queues = [[], [], [5, 5, 5], [], [], [], []]
      subject { TheLift::Operator.new(queues: queues, max_capacity: 5) }

      subject.move(floor: 2)
      subject.onboarding
      expect(subject.people_in_lift).to eq([5, 5, 5])
      subject.move(floor: 5)
      subject.onboarding
      expect(subject.people_in_lift).to eq([])
    end
  end
end
