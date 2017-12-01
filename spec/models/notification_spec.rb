require 'rails_helper'

RSpec.describe Notification, type: :model do
  #it { should belong_to(:agency) }
  # Validation test
  # ensure column name is present before saving
  it { should validate_presence_of(:name) }
end
