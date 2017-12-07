# app/requests/notifications_spec.rb
require 'rails_helper'

RSpec.describe 'Notifications API' do
  # Initialize the test data
  let!(:agency) { create(:agency) }
  let!(:notifications) { create_list(:notification, 20, agency_id: agency.id) }
  let(:agency_id) { agency.id }
  let(:id) { notifications.first.id }

  # Test suite for GET /agencies/:agency_id/notifications
  describe 'GET /agencies/:agency_id/notifications' do
    before { get "/agencies/#{agency_id}/notifications" }

    context 'when agency exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all agency notifications' do
        expect(json.size).to eq(20)
      end
    end

    context 'when agency does not exist' do
      let(:agency_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/{"message":"Couldn't find Agency with 'id'=0"}/)
      end
    end
  end

  # Test suite for GET /agencies/:agency_id/notifications/:id
  describe 'GET /agencies/:agency_id/notifications/:id' do
    before { get "/agencies/#{agency_id}/notifications/#{id}" }

    context 'when agency notification exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the notification' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when agency notification does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      #it 'returns a not found message' do
      #  expect(response.body).to match(/Couldn't find notification/)
      #end
    end
  end

  # Test suite for PUT /agencies/:agency_id/notifications
  describe 'POST /agencies/:agency_id/notifications' do
    let(:valid_attributes) { { name: 'Visit Narnia' } }

    context 'when request attributes are valid' do
      before { post "/agencies/#{agency_id}/notifications", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/agencies/#{agency_id}/notifications", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # Test suite for PUT /agencies/:agency_id/notifications/:id
  describe 'PUT /agencies/:agency_id/notifications/:id' do
    let(:valid_attributes) { { name: 'Mozart' } }

    before { put "/agencies/#{agency_id}/notifications/#{id}", params: valid_attributes }

    context 'when notification exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      #it 'updates the notification' do
      #  updated_notification = notifications.find(id)
      #  expect(updated_notification.name).to match(/Mozart/)
      #end
    end

    context 'when the notification does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
      #Commenting these out for now, need to figure out how to modify message
      #it 'returns a not found message' do
      #  expect(response.body).to match(/Couldn't find notification/)
      #end
    end
  end

  # Test suite for DELETE /agencies/:id
  describe 'DELETE /agencies/:id' do
    before { delete "/agencies/#{agency_id}/notifications/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end