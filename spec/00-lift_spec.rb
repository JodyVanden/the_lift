RSpec.describe TheLift::Lift do
  describe "lift infos" do
    let(:lift) { TheLift::Lift.new(max_capacity: 5) }
    context "initialise the lift" do
      it "should return the intial values of the lift" do
        expect(lift.max_capacity).to eq(5)
        expect(lift.people_count).to eq(0)
        expect(lift.current_floor).to eq(0)
        expect(lift.floor_history.size).to eq(1)
      end
    end
    context "lift changes his position"
    it "the lift changes floor when going up" do
      lift.move(floor: 1)
      expect(lift.current_floor).to eq(1)
    end
    it "the lift has a history after moving up" do
      lift.move(floor: 1)
      expect(lift.current_floor).to eq(1)
    end
    # context "lift capacity" do
    #   it "should counts spaces in the lift" do
    #     lift.move(floor: 1)
    #     lift.people_on(number: 1)
    #     expect(lift.space_left).to eq(4)
    #   end
    # end
  end
end
