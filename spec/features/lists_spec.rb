require 'spec_helper'

describe "Lists" do
  describe "GET /lists" do
    it "should have content" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit lists_path
      page.should have_content('Name')
    end
  end
end
