require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do
	describe '#edit' do
		context 'when user is authenticated' do
			it 'renders the profile form' do
        user = create(:user, :authenticated)
        
        sign_in user

        get :edit

        expect(response).to_not be_redirect
        expect(response.status).to eq(200)
			end
		end
	end

	describe '#show' do
		context 'when user is authenticated' do
			it 'renders the profile' do

			end
		end
	end
end
