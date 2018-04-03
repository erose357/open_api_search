require 'rails_helper'

RSpec.feature "User sees search history" do
  let! (:search_1) { create(:search, search_term: 'batman', updated_at: Time.now) }
  let! (:search_2) { create(:search, search_term: 'fight club', updated_at: Time.parse('2018-01-31')) }
  let! (:search_3) { create(:search, search_term: 'office space', updated_at: Time.parse('2018-02-28')) }

  scenario "only shows unique searches" do
    VCR.use_cassette('repeat_search') do
      visit '/'

      expect(current_path).to eq(root_path)

      fill_in 'title', with: 'fight club'

      click_on 'Search'

      expect(current_path).to eq(search_path)
      expect(page).to have_css('ul li', :text => 'fight club', :count => 1)
      expect(page).to have_css('ul li', :text => 'batman', :count => 1)
      expect(page).to have_css('ul li', :text => 'office space', :count => 1)
      expect(page).to have_css('ul li p', :text => 'search count: 2', :count => 1)
      expect(page).to have_css('ul li p', :text => 'search count: 1', :count => 2)
    end

    VCR.use_cassette('repeat_search') do

      fill_in 'title', with: 'fight club'

      click_on 'Search'

      expect(current_path).to eq(search_path)
      expect(page).to have_css('ul li', :text => 'fight club', :count => 1)
      expect(page).to have_css('ul li p', :text => 'search count: 3', :count => 1)
    end
  end

  scenario "can sort history by date" do
    visit '/'

    expect(current_path).to eq(root_path)
    expect(page).to have_css('ul li', :text => 'fight club', :count => 1)
    expect(page).to have_css('ul li', :text => 'batman', :count => 1)
    expect(page).to have_css('ul li', :text => 'office space', :count => 1)
    expect(page).to have_content('last searched: ', :count => 3)
    expect(page).to have_css('h3', :text => 'Sort by:')
    expect(page).to have_link('date')
    expect(page).to have_link('count')
    expect(page).to have_link('search')

    click_link 'date'

    expect(current_path).to eq(root_path)
    expect(page.all('ul li a').map(&:text)).to eq(['batman', 'office space', 'fight club'])
  end
end
