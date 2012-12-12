require 'spec_helper'
 
describe "user registration" do
	it 'allows new users to register with an email address, password and phone_number' do
		visit "/users/sign_up"
		fill_in "user_email", 									:with => "joe@todo.com"
		fill_in "user_password", 								:with => "testing123"
		fill_in "user_password_confirmation",		:with => "testing123"
		fill_in "user_phone_number", 						:with => "610-741-7722"
		
		click_button "Sign up"
		
		page.should have_content("Welcome! You have signed up successfully.")
  end
end