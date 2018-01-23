require 'rails_helper'

RSpec.describe UserSubscription, type: :model do
  it { should belong_to(:notification) }
  # Validation test
  # ensure column name is present before saving
  it { should validate_presence_of(:name) }
end
