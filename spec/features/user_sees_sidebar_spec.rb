require 'rails_helper'

RSpec.feature "User sees sidebar" do
  let! (:search_1) { create(:search, search_term: 'batman') }
  let! (:search_2) { create(:search, search_term: 'fight club') }
  let! (:search_3) { create(:search, search_term: 'office space') }

  scenario "with previous searches" do
    visit '/'

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Previous Searches')
    expect(page).to have_link('fight club')
    expect(page).to have_css('ul li p', :text => 'search count: 1', :count=> 3)
    expect(page).to have_link('batman')
    expect(page).to have_link('office space')
  end

  scenario "can click links to previous searches and re-run the search" do
    VCR.use_cassette('sidebar-links') do
      visit '/'

      expect(current_path).to eq(root_path)
      expect(page).to have_content('Previous Searches')
      expect(page).to have_link('office space')

      click_link('office space')

      expect(current_path).to eq(search_path(search_3.search_term))
      expect(page).to have_content('Office Space')
      expect(page).to have_content('1999-02-19')
      expect(page).to have_css('td.title', count: 2)
      expect(page).to have_css('td.overview', count: 2)
      expect(page).to have_css('td.release-date', count: 2)
    end
  end

  scenario "clicking previous search links increases count but does not add a new search record" do
      visit '/'

      expect(current_path).to eq(root_path)
      expect(page).to have_content('Previous Searches')
      expect(page).to have_css('ul li', :text => 'batman', :count => 1)
      expect(page).to have_css('ul li', :text => 'fight club', :count => 1)
      expect(page).to have_css('ul li', :text => 'office space', :count => 1)

    VCR.use_cassette('sidebar-link-repeat', :match_requests_on => [:host]) do

      click_link ('fight club')

      expect(page).to have_css('ul li', :text=> 'fight club', :count => 1)
      expect(page).to have_css('ul li', :text => 'fight club search count: 2', :count => 1)
    end

    VCR.use_cassette('sidebar-link-repeat', :match_requests_on => [:host]) do

      click_link ('fight club')

      expect(page).to have_css('ul li', :text=> 'fight club', :count => 1)
      expect(page).to have_css('ul li', :text => 'fight club search count: 3', :count => 1)
    end
  end
end
