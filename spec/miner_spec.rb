require 'spec_helper'

describe Miner do

  let(:miner) { Miner.new("#{SPEC_FIXTURES_ROOT}/page.html", "#{SPEC_FIXTURES_ROOT}/instructions.yml") }

  describe "#mine" do
    it "returns a hash" do
      expect(miner.mine).to be_a(Hash)
    end

    context "when selector exists" do
      it "returns an Array" do
        expect(miner.mine['an_array']).to be_a(Array)
      end

      it "is not empty" do
        expect(miner.mine['an_array'].count).to be > 0
      end
    end

    context "when selector does not exist" do
      it "returns an Array" do
        expect(miner.mine['not_existing_element']).to be_a(Array)
      end

      it "is empty" do
        expect(miner.mine['not_existing_element'].count).to be == 0
      end
    end
  end

end
