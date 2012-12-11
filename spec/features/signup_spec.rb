describe "the signup process", :type => :feature do
  before :each do
    User.make(:email => 'mike@todo.com', :password => 'testing123')
  end

  it "signs me in" do
    within("#session") do
      fill_in 'Email', :with => 'mike@todo.com'
      fill_in 'Password', :with => 'testing123'
    end
    click_link 'Sign in'
  end
end