require_relative "spec_helper_lite"
require_relative "../lib/extentions"

describe Extentions do
  before(:each) do
    Extentions.reset
  end

  after(:each) do
    Extentions.reset
  end

  describe "#extentions_for" do
    it "should apply all extentions to arguments" do
      args = [stub, stub]
      extention1 = stub(:extention1)
      extention2 = stub(:extention2)
      Extentions.register extention1
      Extentions.register extention2

      extention1.should_receive(:apply).with(*args)
      extention2.should_receive(:apply).with(*args)

      Extentions.extentions_for(*args)
    end

    it "should return Extentions::Collection" do
      Extentions.extentions_for(stub).should be_a Extentions::Collection
    end
  end

  describe "Collection" do
    describe "#build_presener" do
      it "should return an object in format token => string" do
        first_rendered_content = stub(:first_rendered_content)
        first_rendered_content.stub_chain(:to_s, :html_safe).and_return('first extention rendered')
        second_rendered_content = stub(:second_rendered_content)
        second_rendered_content.stub_chain(:to_s, :html_safe).and_return('second extention rendered')

        first_extention  = stub(:first_extention, to_token: :first_token, render: first_rendered_content)
        second_extention = stub(:second_extention, to_token: :second_token, render: second_rendered_content)

        collection = Extentions::Collection.new stub, [first_extention, second_extention]
        presenter = collection.build_presenter

        presenter.first_token.should eq 'first extention rendered'
        presenter.second_token.should eq 'second extention rendered'
      end

      it "should decorate a model" do
        model = stub(:model)
        model.stub(:name).and_return('Model name')
        presenter = Extentions.extentions_for(model).build_presenter
        presenter.name.should eq model.name
      end
    end

    describe "#process!" do
      it "should process all extentions" do
        optional_args = stub
        first_extention  = stub(:first_extention)
        second_extention = stub(:second_extention)

        first_extention.should_receive(:process).with(optional_args)
        second_extention.should_receive(:process).with(optional_args)

        collection = Extentions::Collection.new stub, [first_extention, second_extention]
        collection.process!(optional_args)
      end
    end

    describe "Presenter" do
      it "should delegate #class method to a model" do
        model = stub
        presenter = Extentions::Collection::Presenter.new(model, {})
        presenter.class.should eq model.class
      end
    end

  end
end
