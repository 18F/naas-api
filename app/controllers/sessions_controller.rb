class SessionsController < ActionController::Base
  include SessionsHelper

  layout 'uswds'

  before_action :verify_omniauthenticated, except: :create

  def create
    auth_hash = request.env['omniauth.auth']
    session[:auth] = { login_uid: auth_hash['uid'],
                       email: auth_hash['info']['email'] }

    user = User.from_omniauth(auth_hash)

    if user.save
      log_in_user(user)
      redirect_to link_success_url
    end
  end

  def link_success
    redirect_to edit_profile_path if @user.phone.blank?
  end

  def error; end

  private

  def verify_omniauthenticated
    @user = User.find(session[:user_id])
    redirect_to error_path if @user.login_uid.blank?
  end
end
