# spec/requests/notifications_spec.rb
require 'rails_helper'

RSpec.describe 'notifications API', type: :request do
  let!(:notifications) { create_list(:notification, 10) }
  let(:notification_id) { notifications.first.id }
  let!(:user) { create(:user) }
  let(:user_id) { user.id }
  let(:user_email) { user.email }
  let(:user_password) { user.password }

  # Test suite for GET /notifications
  describe 'GET /notifications' do
    # make HTTP get request before each example
    before { get '/notifications', headers: auth_headers(user.id) }

    it 'returns notifications' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /notifications/:id
  describe 'GET /notifications/:id' do
    before { get "/notifications/#{notification_id}", headers: auth_headers(user.id) }

    context 'when the record exists' do
      it 'returns the notification' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(notification_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:notification_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Notification with 'id'=100/)
      end
    end
  end

  # Test suite for POST /notifications
  describe 'POST /notifications' do
    # valid payload
    let(:valid_attributes) { { name: 'Learn Elm', created_by: '1' } }

    context 'when the request is valid' do
      before { post '/notifications', params: valid_attributes, headers: auth_headers(user.id) }

      it 'creates a notification' do
        expect(json['name']).to eq('Learn Elm')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/notifications', params: { name: 'Foobar' }, headers: auth_headers(user.id) }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).
          to match(/Validation failed: Created by can't be blank/)
      end
    end
  end

  # Test suite for PUT /notifications/:id
  describe 'PUT /notifications/:id' do
    let(:valid_attributes) { { name: 'Shopping' } }

    context 'when the record exists' do
      before { put "/notifications/#{notification_id}", params: valid_attributes, headers: auth_headers(user.id) }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /notifications/:id
  describe 'DELETE /notifications/:id' do
    before { delete "/notifications/#{notification_id}", headers: auth_headers(user.id) }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end

  # Test suite for multiple SMS send
  describe 'POST /users' do
    let(:valid_attributes) {
      { last_name: 'Doolittle', email: 'fakey@veryfake.com', password: 'evenfakerer',
                              password_confirmation: 'evenfakerer', phone: '1 222 555 1244' }}

    before do
      post '/users',
                  params: valid_attributes,
                  headers: auth_headers(user_id)

      post "/notifications/#{notification_id}/user_subscriptions",
                  params: { "user_id": user_id, "name": 'targeted_alert' },
                  headers: auth_headers(user_id)

      post "/notifications/#{notification_id}/user_subscriptions",
                  params: { "user_id": 2, "name": 'targeted_alert' },
                  headers: auth_headers(user_id)

      post "/notifications/#{notification_id}/send_group_notification",
                  params: { "body": 'hello humanz' },
                  headers: auth_headers(user.id)

      post "/notifications/#{notification_id}/send_group_notification",
                  params: { "body": 'hello humanz again' },
                  headers: auth_headers(user.id)
    end

    it 'sends message to all provided numbers' do
      expect(FakeSMS.messages.last.num).to eq('+12225551244')
      expect(FakeSMS.messages[-2].num).to eq(user.phone)
      expect(FakeSMS.messages.size).to eq(4)
    end

    it 'creates notification events for each notification instance' do
      expect(user.notification_events.size).to eq(2)
      expect(user.notification_events.last.body).to match(/hello humanz again/)
      expect(response.body).to match(/result\":\"success\",\"user_count\":2/)
    end
  end
end
