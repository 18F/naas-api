class SubscribeController < ApplicationController
  include SmsTool

  def show
    #authenticate_request
    SmsTool.send_sms(params[:phone],
                     "Welcome to Notifications-as-a-Service or NAAS. To continue receiving messages reply with 'YES'",
                     "My App")
  end

  def confirm
    message_body = params["Body"]
    from_number = params["From"]
    @user = User.find_by!(phone: from_number[1,from_number.length - 1])
    if @user && message_body.upcase == 'YES' || message_body.upcase[0,1] == 'Y'
      @user.confirmed = true
      @user.save
    elsif !@user
      not_found
    end

  end

  private

  def user_params
    # whitelist params
    params.permit(:email, :phone, :name, :body, :source_app)

  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

end
