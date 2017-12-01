require 'rails_helper'

RSpec.describe Agency, type: :model do
  #it { should have_many(:notifications).dependent(:destroy) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:created_by) }
end
