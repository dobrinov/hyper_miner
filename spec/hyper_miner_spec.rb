require 'spec_helper'

describe HyperMiner do

  let(:miner) { HyperMiner.new("#{SPEC_FIXTURES_ROOT}/example.html") }

  describe "#mine" do

    it "is a Hash" do
      mined_data = miner.mine {}
      expect(mined_data).to be_a(Hash)
    end

    context "when selectors exist" do

      context "when the node content has the right type" do
        it "mines an integer" do
          mined_data = miner.mine do
            integer 'total', selector: 'div#total'
          end

          expect(mined_data['total']).to be_a(Integer)
        end

        it "mines a string" do
          mined_data = miner.mine do
            text 'description', selector: 'div#description'
          end

          expect(mined_data['description']).to be_a(String)
        end
      end


      context "when the node content does not have the right type" do
        it "assigns zero for Integer" do
          mined_data = miner.mine do
            integer 'total', selector: 'div#description'
          end

          expect(mined_data['total']).to be 0
        end
      end

    end

    context "when selector do not exist" do
      it "assigns nil values" do
        mined_data = miner.mine do
          integer 'non_existing_integer', selector: 'div#non_existing_integer'
          text    'non_existing_text',    selector: 'div#non_existing_text'
        end

        expect(mined_data['non_existing_integer']).to be_nil
        expect(mined_data['non_existing_text']).to be_nil
      end
    end

    context "when no mine instructions are provided" do
      it "raises error" do
        expect { miner.mine }.to raise_error
      end
    end
  end
end
