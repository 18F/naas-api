# spec/requests/agencies_spec.rb
require 'rails_helper'

RSpec.describe 'Agencies API', type: :request do
  # initialize test data
  let!(:agencies) { create_list(:agency, 10) }
  let(:agency_id) { agencies.first.id }

  # Test suite for GET /agencies
  describe 'GET /agencies' do
    # make HTTP get request before each example
    before { get '/agencies' }

    it 'returns agencies' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /agencies/:id
  describe 'GET /agencies/:id' do
    before { get "/agencies/#{agency_id}" }

    context 'when the record exists' do
      it 'returns the agency' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(agency_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:agency_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Agency with 'id'=100/)
      end
    end
  end

  # Test suite for POST /agencies
  describe 'POST /agencies' do
    # valid payload
    let(:valid_attributes) { { name: 'Learn Elm', created_by: '1' } }

    context 'when the request is valid' do
      before { post '/agencies', params: valid_attributes }

      it 'creates a agency' do
        expect(json['name']).to eq('Learn Elm')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/agencies', params: { name: 'Foobar' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
            .to match(/Validation failed: Created by can't be blank/)
      end
    end
  end

  # Test suite for PUT /agencies/:id
  describe 'PUT /agencies/:id' do
    let(:valid_attributes) { { name: 'Shopping' } }

    context 'when the record exists' do
      before { put "/agencies/#{agency_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /agencies/:id
  describe 'DELETE /agencies/:id' do
    before { delete "/agencies/#{agency_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end