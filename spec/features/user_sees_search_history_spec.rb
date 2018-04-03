require 'rails_helper'

RSpec.feature "User sees search history" do
  let! (:search_1) { create(:search, search_term: 'batman', search_count: 2, updated_at: Time.now) }
  let! (:search_2) { create(:search, search_term: 'fight club', updated_at: Time.parse('2018-01-31')) }
  let! (:search_3) { create(:search, search_term: 'office space', search_count: 3, updated_at: Time.parse('2018-02-28')) }

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
      expect(page).to have_css('ul li p.count', :text => 'search count: 2', :count => 2)
      expect(page).to have_css('ul li p', :text => 'search count: 3', :count => 1)
    end

    VCR.use_cassette('repeat_search') do

      fill_in 'title', with: 'fight club'

      click_on 'Search'

      expect(current_path).to eq(search_path)
      expect(page).to have_css('ul li', :text => 'fight club', :count => 1)
      expect(page).to have_css('ul li p', :text => 'search count: 3', :count => 2)
    end
  end

  scenario "can sort history by date, count, and search_term" do
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

    click_link 'count'

    expect(current_path).to eq(root_path)
    expect(page.all('ul li p.count').map(&:text)).to eq(['search count: 3', 'search count: 2', 'search count: 1'])

    click_link 'search'

    expect(current_path).to eq(root_path)
    expect(page.all('ul li a').map(&:text)).to eq(['batman', 'fight club', 'office space'])
  end

  scenario "sees past search information" do
    VCR.use_cassette('repeat_search') do
      visit '/'

      expect(current_path).to eq(root_path)

      click_on 'fight club'

      expect(page).to have_content('Search History')
      expect(page).to have_content('Search Information')
      expect(page).to have_content('Total Search Count:')
      expect(page).to have_css('ul li.past-searches', count: 2)

    end

    VCR.use_cassette('repeat_search') do
      click_on 'fight club'

      expect(page).to have_css('ul li.past-searches', count: 3)
    end
  end
end
