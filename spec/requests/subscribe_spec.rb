require 'rails_helper'

RSpec.describe 'subscribe API', type: :request do
  let!(:user) { create(:user) }

  headers = {
    'ACCEPT' => 'application/json'
  }
  
  describe 'POST /subscribe' do
    let(:valid_attributes) { { phone: "1234567890",
                              body: "A Sample Subscribe Message",
                              source_app: "my_app_name" } }

    context 'when subscibe message is sent' do
      before { post '/subscribe', params: valid_attributes, headers: auth_headers(user.id) }

      it 'sends message to provided number' do
        expect(FakeSMS.messages.last.num).to eq('1234567890')
      end
    end
  end

  describe 'POST /confirm' do
    let(:valid_attributes) { { From: '+' + user.phone, Body: 'YES' } }

    context 'when reply is sent' do
      before { post '/confirm', params: valid_attributes }
      it 'modifies user object to confirmed' do
        user.reload
        expect(user.confirmed).to eq(true)
      end
    end

    context 'when number is not found' do
      before { post '/confirm', params: { From: '+2' } }

      it 'returns object not found' do
        expect(response).to have_http_status(404)
      end
    end
  end
end
