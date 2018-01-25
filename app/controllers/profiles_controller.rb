class ProfilesController < ActionController::Base
	layout 'uswds'
	before_action :set_user

	def edit
	end

	def update
		@user.phone = safe_params[:phone]

		if @user.save && !@user.phone.nil?
			redirect_to link_success_path
		else
			redirect_to edit_profile_path(errors: true)
		end
	end

	private

	def set_user
		@user = User.find(session[:user_id])
	end

	def safe_params
		params.require(:user).permit(:phone)
	end
end
