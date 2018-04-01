require 'rails_helper'

RSpec.feature "User sees sidebar" do
  let! (:search_1) { create(:search, search_term: 'cyclops') }
  let! (:search_2) { create(:search, search_term: 'wolverine') }
  let! (:search_3) { create(:search, search_term: 'juggernaut') }

  scenario "with previous searches" do
    visit '/'

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Previous Searches')
    expect(page).to have_link('cyclops')
    expect(page).to have_css('ul li p', :text => 'search count: 1', :count=> 3)
    expect(page).to have_link('wolverine')
    expect(page).to have_link('juggernaut')
  end

  scenario "can click links to previous searches and re-run the search" do
    VCR.use_cassette('sidebar-links', :match_requests_on => [:host]) do
      visit '/'

      expect(current_path).to eq(root_path)
      expect(page).to have_content('Previous Searches')
      expect(page).to have_link('cyclops')

      click_link('cyclops')

      expect(current_path).to eq(search_path(search_1.search_term))
      expect(page).to have_content('Cyclops')
      expect(page).to have_content('Cyclops (Ultimate)')
      expect(page).to have_content('Cyclops (X-Men: Battle of the Atom')
    end
  end
end
