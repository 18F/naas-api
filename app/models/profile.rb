class Profile
  include ActiveModel::Model


  def email
  	user.email
  end

  def phone
  	user.phone
  end
end