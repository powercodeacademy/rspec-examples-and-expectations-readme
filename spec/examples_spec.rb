require_relative "../lib/recipe_timer"

RSpec.describe RecipeTimer do
  describe "#initialize" do
    it "sets the duration and initializes elapsed to 0" do
      timer = RecipeTimer.new(60)
      expect(timer.duration).to eq(60)
      expect(timer.elapsed).to eq(0)
      expect(timer.running).to eq(false)
    end
  end

  describe "#start and #stop" do
    let(:timer) { RecipeTimer.new(30) }

    it "starts the timer" do
      timer.start
      expect(timer.running).to be true
    end

    it "can start the timer multiple times after reset" do
      timer.start
      timer.tick(10)
      timer.stop
      timer.reset
      timer.start
      expect(timer.running).to be true
    end

    it "stops the timer" do
      timer.start
      timer.stop
      expect(timer.running).to be false
    end
  end

  describe "#tick" do
    let(:timer) { RecipeTimer.new(10) }

    it "does not advance if not running" do
      timer.tick(5)
      expect(timer.elapsed).to eq(0)
    end

    it "advances elapsed time when running" do
      timer.start
      timer.tick(4)
      expect(timer.elapsed).to eq(4)
    end

    it "does not exceed duration" do
      timer.start
      timer.tick(15)
      expect(timer.elapsed).to eq(10)
    end

    it "does not allow negative values" do
      expect(timer.elapsed).to be > -1
    end

  end

  describe "#reset" do
    it "resets elapsed and stops the timer" do
      timer = RecipeTimer.new(20)
      timer.start
      timer.tick(10)
      timer.reset
      expect(timer.elapsed).to eq(0)
      expect(timer.running).to be false
    end
  end

  describe "#finished?" do
    it "returns false if not finished" do
      timer = RecipeTimer.new(5)
      timer.start
      timer.tick(3)
      expect(timer.finished?).to be false
    end

    it "returns true if elapsed equals duration" do
      timer = RecipeTimer.new(5)
      timer.start
      timer.tick(5)
      expect(timer.finished?).to be true
    end

    it "returns true if elapsed exceeds duration" do
      timer = RecipeTimer.new(5)
      timer.start
      timer.tick(10)
      expect(timer.finished?).to be true
    end
  end
end
