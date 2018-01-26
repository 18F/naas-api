# lib/sms_tool.rb

module SmsTool
  account_sid = Rails.application.secrets.twilio_sid
  auth_token = Rails.application.secrets.twilio_auth_token
  @client = Twilio::REST::Client.new account_sid, auth_token

  def self.send_sms(num, msg, app)
    @client.messages.create(
        from: Rails.application.secrets.twilio_number,
        to: "#{num}",
        body: "#{msg} from #{app}"
    )
  end
end