require 'spec_helper'

describe List do 

	before(:each) do
		user = FactoryGirl.create(:user)
		list = FactoryGirl.create(:list)
		task = FactoryGirl.create(:task)
		
		user_list = user.lists.create(:name 				=> list.name, 
														 			:description 	=> list.description)

		user_list.tasks.create(:description 	=> task.description, 
														 					 :priority 		 			=> task.priority, 
														 					 :due_at 			 			=> task.due_at, 			
														 					 :tag					 			=> task.tag,		
														 					 :sms_reminder			=> task.sms_reminder)
	end

	it "cannot have desc and name less than 3 char" do
		list1 = List.create(:name => "my", :description => "ne")
		list1.should_not be_valid
	end

	it "must name and desc with at least 3 char" do
		list2 = List.create(:name => "my list", :description => "new list")
		list2.should be_valid
	end

	it "list belongs to user" do
		
	end

end