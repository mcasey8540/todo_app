require 'twilio-ruby'

# Inputs
sid = 'AC1714be77fe4c23e291215baead5e5b5f'
token = 'c55f2685349b65367edb9dfba4fc142b'
from = '+114156399417'
to = '+16107417722'

# This is where we can generate a custom message for the user!
# Pull in data from your database, from API's, etc. and crunch it into something interesting.
# But for this example, we'll just set it to this:
body = "Hello from TodoApp!"


# Initialize the Twilio client
@client = Twilio::REST::Client.new(sid, token)

# Send the message
r = @client.account.sms.messages.create(
    :from => from,
    :to => to,
    :body => body
)