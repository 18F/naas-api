module SmsTool
  account_sid = ENV['TWILIO_ACCOUNT_SID']
  auth_token = ENV['TWILIO_AUTH_TOKEN']

  #@client = Twilio::REST::Client.new account_sid, auth_token

  @twilio_client = Twilio::REST::Client.new account_sid, auth_token
  @twilio_number = '2028998939'

  def self.send_sms(num, msg, app)
    @twilio_client.messages.create(
        from: @twilio_number,
        to: "+1#{num}",
        body: "#{msg} from #{app}"
    )
  end
end