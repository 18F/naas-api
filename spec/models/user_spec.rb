require 'rails_helper'

RSpec.describe User, type: :model do
  it { should_not validate_presence_of(:last_name) }
  it { should validate_presence_of(:email) }
  it { should_not validate_presence_of(:phone) }
  it { should validate_uniqueness_of(:email) }
  xit { should validate_uniqueness_of(:phone) }

  it 'normalizes phone' do
	  user = create(:user, phone: '  555 555 5555    ')

	  expect(user.phone).to eq '+15555555555'
	end
end
