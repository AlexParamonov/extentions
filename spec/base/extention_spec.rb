require_relative "../spec_helper_lite"
require_relative "../../lib/extentions/base/extention"
require_relative "../../lib/extentions/null/extention"

describe Extentions::Base::Extention do
  let(:extention) { Extentions::Base::Extention }
  let(:args) { [stub, stub] }
  let(:applied_extention) { extention.apply(*args) }

  describe "#apply" do
    it "should return new instance if extention is valid" do
      extention.any_instance.stub(:valid?).and_return(true)
      applied_extention.should be_a extention
    end

    it "should return NullExtention if extention is invalid"do
      extention.any_instance.stub(:valid?).and_return(false)
      applied_extention.should be_a Extentions::Null::Extention
    end
  end

  it "should be convertable to token" do
    extention.any_instance.stub(valid?: true)
    applied_extention.to_token.should eq :base
  end
end
