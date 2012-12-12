FactoryGirl.define do
	factory :user do
		email										"joe@todo.com"
		password								"testing123"
		password_confirmation		"testing123"
		phone_number						"610-741-7722"
	end

	factory :list do 
		name										"New Years 2013"
		description							"holiday plans"
	end

	factory :task do 
		description							"vienna trip"
  	priority  						 	"low"
  	due_at									Time.now
  	tag											"Travel"
  	sms_reminder						"3"
  end

end