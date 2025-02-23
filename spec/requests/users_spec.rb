# spec/requests/users_spec.rb
require 'rails_helper'

RSpec.describe 'users API', type: :request do
  # initialize test data
  let!(:users) { create_list(:user, 10) }
  let(:user_id) { users.first.id }
  let(:user_email) { users.first.email}
  let(:user_password) {users.first.password}

  # Test suite for GET /users
  describe 'GET /users' do
    # make HTTP get request before each example
    before { get '/users', headers: auth_headers(user_id) }

    it 'returns users' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /users/:id
  describe 'GET /users/:id' do
    before { get "/users/#{user_id}", headers: auth_headers(user_id) }

    context 'when the record exists' do
      it 'returns the user' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(user_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:user_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find User with 'id'=100/)
      end
    end
  end

  # Test suite for POST /users
  describe 'POST /users' do
    # valid payload
    let(:valid_attributes) { { last_name: 'Doolittle', email: 'fake@veryfake.com', password: 'evenfakerer',
                               password_confirmation: 'evenfakerer', phone: 1234567} }

    context 'when the request is valid' do
      before { post '/users', params: valid_attributes, headers: auth_headers(user_id) }


      it 'creates a user' do
        expect(json['last_name']).to eq('Doolittle')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/users', params: { first_name: 'Foobar' }, headers: auth_headers(user_id) }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
            .to match(/Validation failed: Password can't be blank, Email can't be blank, Last name can't be blank, Phone can't be blank/)
      end
    end
  end

  # Test suite for PUT /users/:id
  describe 'PUT /users/:id' do
    let(:valid_attributes) { { name: 'Shopping' } }

    context 'when the record exists' do
      before { put "/users/#{user_id}", params: valid_attributes, headers: auth_headers(user_id) }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /users/:id
  describe 'DELETE /users/:id' do
    before { delete "/users/#{user_id}", headers: auth_headers(user_id) }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end