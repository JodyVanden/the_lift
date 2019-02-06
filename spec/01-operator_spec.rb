RSpec.describe TheLift::Operator do
  let(:queues_1) { [[], [], [5, 5, 5], [], [], [], []] }
  let(:queues_2) { [[], [], [1, 1], [], [], [], []] }
  let(:queues_3) { [[], [3], [4], [], [5], [], []] }
  describe "test1" do
    context "lift infos" do
      subject { TheLift::Operator.new(queues: queues_1, max_capacity: 5) }
      it "should initialize the operator" do
        expect(subject.queues).to eq(queues_1)
        expect(subject.current_floor).to eq(0)
        expect(subject.space_left).to eq(5)
      end

      it "should know space left in the lift" do
        subject.onboarding(current_floor: 2)
        expect(subject.space_left).to eq(2)
        expect(subject.current_floor).to eq(2)
        expect(subject.queues).to eq([[], [], [], [], [], [], []])
        expect(subject.people_in_lift).to eq([5, 5, 5])
      end

      it "should take people out of the lift if at the current floor" do
        subject.onboarding(current_floor: 2)
        expect(subject.people_in_lift).to eq ([5, 5, 5])
        subject.onboarding(current_floor: 5)
        expect(subject.people_in_lift).to eq([])
      end
    end

    context "check lift logic" do
      subject { TheLift::Operator.new(queues: queues_1, max_capacity: 5) }
      it "should go first to floor 2" do
        subject.next_floor
        expect(subject.floor_history).to eq([0, 2, 5, 0])
      end
    end
  end

  describe "test2" do
    context " blabla" do
      subject { TheLift::Operator.new(queues: queues_2, max_capacity: 5) }
      it "should go first to floor 2" do
        subject.next_floor
        expect(subject.floor_history).to eq([0, 2, 1, 0])
      end
    end
  end

  describe "test3" do
    context " blabla" do
      subject { TheLift::Operator.new(queues: queues_3, max_capacity: 5) }
      it "should go first to floor 2" do
        subject.next_floor
        expect(subject.floor_history).to eq([0, 1, 2, 3, 4, 5, 0])
      end
    end
  end
end
