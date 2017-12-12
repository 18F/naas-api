require 'rails_helper'

RSpec.describe Notification, type: :model do
  it { should have_many(:user_subscriptions).dependent(:destroy) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:created_by) }
end
