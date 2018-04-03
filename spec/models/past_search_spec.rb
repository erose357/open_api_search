require 'rails_helper'

RSpec.describe PastSearch, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to(:search) }
  end
end
