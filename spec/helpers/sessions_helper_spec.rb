require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the SessionsHelper. For example:
#
# describe SessionsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe SessionsHelper, type: :helper do
  describe 'current_user' do
    it 'returns the currently logged in user' do
      user = create(:user)
      session[:user_id] = user.id
      expect(helper.current_user.id).to eq(user.id)
    end
  end
end
