require_relative "../spec_helper_lite"
require_relative "../../lib/extentions/null/extention"

describe Extentions::Null::Extention do
  it "#to_token should be :null" do
    subject.to_token.should eq :null
  end

  it "#render should be null" do
    subject.render.should be_nil
  end

  it "#valid? should be true" do
    subject.should be_valid
  end
end
