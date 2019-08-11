describe Timer, type: :model do
  let(:new_timer){create :new_timer, billed: true}
  it "should create an hour record when ends_at is added" do
    new_timer.update_attribute(:ends_at, Time.now)
    expect(new_timer.hour).to_not be_nil
  end

  context "with a new hour" do
    let(:hour){ new_timer.hour }
    before do
      new_timer.update_attribute(:ends_at, Time.now)
    end

    it "should set project" do
      expect(hour.project).to_not be_nil
    end

    it "should set category" do
      expect(hour.category).to_not be_nil
    end

    it "should set user" do
      expect(hour.user).to_not be_nil
    end

    it "should set date" do
      expect(hour.date).to_not be_nil
    end

    it "should set description" do
      expect(hour.description).to_not be_nil
    end

    it "should set billed boolean" do
      expect(hour.billed).to be_truthy
    end

    it "should calculate hours" do
      expect(hour.value).to_not be_nil
    end

  end
end
