class SubscribeController < ApplicationController

  #before_action :set_user

  def send
    @twilio_client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid,
                                              Rails.application.secrets.twilio_auth_token
    puts('after env all')
    puts(Rails.application.secrets.twilio_account_sid)
    #@twilio_client = Twilio::REST::Client.new 'AC93eb2ced768ad309d3b9c900c7cf1dfa',
    #                                          '5d854aeb1b48b2ab0233f9f92945d0ef'
    @twilio_phone_number = Rails.application.secrets.twilio_number
    #@twilio_phone_number = '2028998939'

    @twilio_client.api.account.messages.create(
        :from => "+1#{@twilio_phone_number}",
        :to => params[:phone],
        :body => "Welcome to Notifications-as-a-Service or NAAS. To continue receiving messages reply with 'YES'"
    )

  end

  def confirm
    message_body = params["Body"]
    from_number = params["From"]
    puts(message_body)
    puts(from_number)
    puts(from_number[1,from_number.length - 1])
    @user = User.find_by!(phone: from_number[1,from_number.length - 1])
    if message_body.upcase == 'YES' || message_body.upcase[0,1] == 'Y'
      puts('hello! from the if')
      @user.confirmed = true
      @user.save
    end

  end

  private

  def user_params
    # whitelist params
    params.permit(:email, :phone, :name)

  end

end
