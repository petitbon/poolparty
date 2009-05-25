require File.dirname(__FILE__) + '/../spec_helper'

describe "Remote Instance" do
  before(:each) do
    @tc = TestBaseClass.new do
    end
  end
  it "should have the method has_line_in_file available on the class" do
    @tc.respond_to?(:has_line_in_file).should == true
  end
  describe "call" do
    before(:each) do
      @tc.run_in_context do
        has_authorized_key({:for_user => 'alerner', 
                            :public_key_file => "#{::File.dirname(__FILE__)}/../fixtures/fake_key.pub"})
      end
      @compiled = ChefResolver.new(@tc.to_properties_hash).compile
    end
    it "should have the line in the file from ChefResolver" do
      @compiled.should match(/~alerner\/\.ssh/)
    end
  end
end