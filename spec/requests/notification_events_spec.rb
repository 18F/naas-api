require 'rails_helper'

RSpec.describe 'notification events API', type: :request do
  let!(:user) { create(:user) }
  let!(:notification_events) { create_list(:notification_event, 20, user_id: user.id) }
  let(:user_id) { user.id }
  let(:id) { notification_events.first.id }

  # Test suite for GET /notifications/:notification_id/user_subscriptions
  describe 'GET /users/:user_id/notification_events' do
    # ?user_id=" + user_id.to_s

    before { get "/users/#{user_id}/notification_events", headers: auth_headers(user.id) }

    context 'when subscription exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all subscription user_subscriptions' do
        expect(json.size).to eq(20)
      end
    end
  end

  describe 'GET /users/:login_uid/notification_events' do
    let!(:user) { create(:user, :authenticated) }

    before { get "/users/#{user.login_uid}/notification_events", headers: auth_headers(user.id) }

    context 'when events exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all notification events for that user' do
        expect(json.size).to eq(20)
      end
    end
  end

  # Test suite for GET /notifications/:notification_id/user_subscriptions/:id
  describe 'GET /users/:user_id/notification_events/:id' do
    before { get "/users/#{user_id}/notification_events/#{id}", headers: auth_headers(user.id) }

    context 'when notification event exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the notification event' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when subscription notification event does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  # Test suite for PUT /notifications/:notification_id/user_subscriptions
  describe 'POST /notifications/:notification_id/user_subscriptions' do
    let(:valid_attributes) { { body: 'Visit Narnia', user_id: user_id, unread: true } }

    context 'when request attributes are valid' do
      before do 
        post "/users/#{user_id}/notification_events", params: valid_attributes,
                                                             headers: auth_headers(user.id)  end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end

#       it 'expect json to have id of subscription' do
#         expect(json['user_id']).to eq(user_id)
#       end
    end

    context 'when an invalid request' do
      before do 
        post "/users/#{user_id}/notification_events", params: { user_id: user_id },
                                                             headers: auth_headers(user.id)  end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Body can't be blank/)
      end
    end
  end

  # Test suite for PUT /notifications/:notification_id/user_subscriptions/:id
  describe 'PUT /notifications/:notification_id/user_subscriptions/:id' do
    let(:valid_attributes) { { unread: '1' } }

    before do 
      put "/users/#{user_id}/notification_events/#{id}", params: valid_attributes,
                                                                headers: auth_headers(user.id) end

    context 'when user_subscription exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end

    context 'when the user_subscription does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'DELETE /users/:user_id/notification_events/:id' do
    before { delete "/users/#{user_id}/notification_events/#{id}", headers: auth_headers(user.id) }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
