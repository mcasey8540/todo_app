require 'twilio-ruby'

# Inputs
sid = 'AC1714be77fe4c23e291215baead5e5b5f'
token = 'c55f2685349b65367edb9dfba4fc142b'
from = '+14156399417'
to = @params[:to]

if @params[:sms_reminder].to_i < 2
	body = "Hello from TodoApp! You set a SMS reminder for '#{@params[:description]}' that will occur #{@params[:sms_frequency]} hour before the due date: #{@params[:due_at]}."
else 
	body = "Hello from TodoApp! You set a SMS reminder for '#{@params[:description]}' that will occur #{@params[:sms_frequency]} hours before the due date: #{@params[:due_at]}."
end


# Initialize the Twilio client
@client = Twilio::REST::Client.new(sid, token)

# Send the message
r = @client.account.sms.messages.create(
    :from => from,
    :to => to,
    :body => body
)