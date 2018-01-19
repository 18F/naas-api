require 'rails_helper'

RSpec.describe NotificationEvent, type: :model do
  it { should validate_presence_of(:body) }
end
