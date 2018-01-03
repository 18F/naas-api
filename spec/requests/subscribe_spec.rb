require "rails_helper"

RSpec.describe 'subscribe API', type: :request do
  headers = {
      "ACCEPT" => "application/json"
  }
  let(:valid_attributes) {{phone: "1234567890",
                           body: "A Sample Subscribe Message",
                           source_app: "my_app_name"}}


  context 'when subscibe message is sent' do
    before {post "/subscribe", params: valid_attributes, headers: headers}

    it 'returns status code 201' do
      expect(FakeSMS.messages.last.num).to eq("1234567890")
    end
  end
end