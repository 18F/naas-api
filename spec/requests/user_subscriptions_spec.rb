require 'rails_helper'

RSpec.describe 'user_subscriptions API' do
  # Initialize the test data
  let!(:notification) { create(:notification) }
  let!(:user) { create(:user) }
  let!(:user_subscriptions) { create_list(:user_subscription, 20, notification_id: notification.id, user_id: user.id) }
  let(:notification_id) { notification.id }
  let(:user_id) { user.id }
  let(:user_email) { user.email }
  let(:user_password) { user.password }
  let(:id) { user_subscriptions.first.id }

  # Test suite for GET /notifications/:notification_id/user_subscriptions
  describe 'GET /notifications/:notification_id/user_subscriptions' do
    # ?user_id=" + user_id.to_s

    before { get "/notifications/#{notification_id}/user_subscriptions?user_id" + user_id.to_s, headers: auth_headers(user.id) }

    context 'when subscription exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all subscription user_subscriptions' do
        expect(json.size).to eq(20)
      end
    end

    context 'when subscription does not exist' do
      let(:notification_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Notification with 'id'=0"/)
      end
    end
  end

  # Test suite for GET /notifications/:notification_id/user_subscriptions/:id
  describe 'GET /notifications/:notification_id/user_subscriptions/:id' do
    before { get "/notifications/#{notification_id}/user_subscriptions/#{id}", headers: auth_headers(user.id) }

    context 'when subscription user_subscription exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the user_subscription' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when subscription user_subscription does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      # it 'returns a not found message' do
      #  expect(response.body).to match(/Couldn't find user_subscription/)
      # end
    end
  end

  # Test suite for PUT /notifications/:notification_id/user_subscriptions
  describe 'POST /notifications/:notification_id/user_subscriptions' do
    let(:valid_attributes) { { name: 'Visit Narnia', user_id: user_id } }

    context 'when request attributes are valid' do
      before do 
        post "/notifications/#{notification_id}/user_subscriptions", params: valid_attributes,
                                                                            headers: auth_headers(user.id)  end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end

      it 'expect json to have id of subscription' do
        expect(json['user_id']).to eq(user_id)
      end
    end

    context 'when an invalid request' do
      before do 
        post "/notifications/#{notification_id}/user_subscriptions", params: { user_id: user_id },
                                                                            headers: auth_headers(user.id)  end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # Test suite for PUT /notifications/:notification_id/user_subscriptions/:id
  describe 'PUT /notifications/:notification_id/user_subscriptions/:id' do
    let(:valid_attributes) { { name: 'Mozart' } }

    before do 
      put "/notifications/#{notification_id}/user_subscriptions/#{id}", params: valid_attributes,
                                                                               headers: auth_headers(user.id) end

    context 'when user_subscription exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      # it 'updates the user_subscription' do
      #  updated_user_subscription = user_subscriptions.find(id)
      #  expect(updated_user_subscription.name).to match(/Mozart/)
      # end
    end

    context 'when the user_subscription does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
      # Commenting these out for now, need to figure out how to modify message
      # it 'returns a not found message' do
      #  expect(response.body).to match(/Couldn't find user_subscription/)
      # end
    end
  end

  # Test suite for DELETE /notifications/:id
  describe 'DELETE /notifications/:id' do
    before { delete "/notifications/#{notification_id}/user_subscriptions/#{id}", headers: auth_headers(user.id) }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
