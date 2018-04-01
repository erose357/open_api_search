require 'rails_helper'

RSpec.describe Search, type: :model do
  let! (:search) { create(:search) }

  describe 'Validations' do
    it { is_expected.to validate_uniqueness_of(:search_term) }
  end

  describe 'Class methods' do
    describe '.update_or_create' do
      it 'updates the search_count of an existing record' do
        Search.update_or_create(search.search_term)

        expect(Search.find(search.id).search_count).to eq(2)
      end
      it 'if no matching record found it creates a new record' do
        new_search = Search.update_or_create('deadpool')

        expect(new_search).to be_an_instance_of(Search)
        expect(new_search.search_term).to eq('deadpool')
        expect(new_search.search_count).to eq(1)
      end
    end
  end
end
