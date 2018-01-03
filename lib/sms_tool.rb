# lib/sms_tool.rb

module SmsTool
  account_sid = ENV['TWILIO_ACCOUNT_SID']
  auth_token = ENV['TWILIO_AUTH_TOKEN']
  puts(auth_token)
  @client = Twilio::REST::Client.new account_sid, auth_token

  def self.send_sms(num, msg, app)
    @client.messages.create(
        from: ENV['TWILIO_PHONE_NUMBER'],
        to: "+1#{num}",
        body: "#{msg} from #{app}"
    )
  end
end