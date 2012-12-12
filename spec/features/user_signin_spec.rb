require 'spec_helper'

describe "user sign in" do 
	it "allows users to sign in after they have registered" do

		user = User.create(:email => "joe@todo.com", :password => "testing123")

		visit "/users/sign_in"

		fill_in "user_email", 		:with => user.email
		fill_in "user_password",	:with => user.password

		click_button "Sign in"
	end
end