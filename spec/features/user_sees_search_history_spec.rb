require 'rails_helper'

RSpec.feature "User sees search history" do
  let! (:search_1) { create(:search, search_term: 'hulk', updated_at: Time.now) }
  let! (:search_2) { create(:search, search_term: 'magneto', updated_at: Time.parse('2018-01-31')) }
  let! (:search_3) { create(:search, search_term: 'deadpool', updated_at: Time.parse('2018-02-28')) }

  scenario "only shows unique searches" do
    VCR.use_cassette('repeat_search', :match_requests_on => [:host]) do
      visit '/'

      expect(current_path).to eq(root_path)

      fill_in 'name', with: 'magneto'

      click_on 'Search'

      expect(current_path).to eq(search_path)
      expect(page).to have_css('ul li', :text => 'magneto', :count => 1) 
      expect(page).to have_css('ul li', :text => 'hulk', :count => 1) 
      expect(page).to have_css('ul li', :text => 'deadpool', :count => 1) 
      expect(page).to have_css('ul li p', :text => 'search count: 2', :count => 1)
      expect(page).to have_css('ul li p', :text => 'search count: 1', :count => 2)
    end
    VCR.use_cassette('repeat_search', :match_requests_on => [:host]) do

      fill_in 'name', with: 'magneto'

      click_on 'Search'

      expect(current_path).to eq(search_path)
      expect(page).to have_css('ul li', :text => 'magneto', :count => 1)
      expect(page).to have_css('ul li p', :text => 'search count: 3', :count => 1)
    end
  end

  scenario "can sort history by date" do
    visit '/'

    expect(current_path).to eq(root_path)
    expect(page).to have_css('ul li', :text => 'magneto', :count => 1) 
    expect(page).to have_css('ul li', :text => 'hulk', :count => 1) 
    expect(page).to have_css('ul li', :text => 'deadpool', :count => 1) 
    expect(page).to have_content('last searched: ', :count => 3)
    expect(page).to have_css('h3', :text => 'Sort by:')
    expect(page).to have_button('date')
    expect(page).to have_button('count')
    expect(page).to have_button('search')

    click_button 'date'

    expect(current_path).to eq(root_path)
    expect(page.all('ul li a').map(&:text)).to eq(['hulk', 'deadpool', 'magneto'])
  end
end
