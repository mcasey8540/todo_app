# Inputs
#
  sid = 'AC1714be77fe4c23e291215baead5e5b5f'
  token = 'c55f2685349b65367edb9dfba4fc142b'
  from = '+14156399417'
	to = '+16107417722'
#

require 'twilio-ruby'
require 'uber_config'

# little worker hack to run it locally
begin
  @config = UberConfig.load()
  #@params = @config
rescue => ex
  @config = params
end

# LOOK HERE!
# This is where we can generate a custom message for the user!
# Pull in data from your database, from API's, etc. Maybe crunch it into something interesting...
# But for now, we'll just set it to this:
@users = User.all

body = "Hello from IronWorker! "

# set up a client to talk to the Twilio REST API
@client = Twilio::REST::Client.new sid, token

if to
# And finally, send the message
  r = @client.account.sms.messages.create(
      :from => from,
      :to => to,
      :body => body
  )
  p r
end