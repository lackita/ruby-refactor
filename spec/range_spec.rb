require "spec_helper"
require "range"

RSpec.describe Range do
  describe "#overlaps?" do
    it { expect(1..1).to be_overlap(1..1) }
    it { expect(1..2).to be_overlap(1..1) }
    it { expect(1..1).to be_overlap(1..2) }
    it { expect(1..3).to be_overlap(2..2) }
    it { expect(2..2).to be_overlap(1..3) }
    it { expect(1..2).to_not be_overlap(3..4) }
    it { expect(1..2).to_not be_overlap(2..1) }
  end
end
