module ControllerSpecHelpers
  def authenticate user
    token = Token.where(id: user.id).first || Factory.create(:api_token, id: user.id)
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(token.hex)
  end
end