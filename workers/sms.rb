require 'twilio-ruby'

# Inputs
sid = 'AC1714be77fe4c23e291215baead5e5b5f'
token = 'c55f2685349b65367edb9dfba4fc142b'
from = '+14156399417'
to = @params[:to]
body = "TodoApp Reminder: '#{@params[:description]}' is due at '#{@params[:due_at]}'"


# Initialize the Twilio client
@client = Twilio::REST::Client.new(sid, token)


# Send the message
r = @client.account.sms.messages.create(
    :from => from,
    :to => to,
    :body => body
)