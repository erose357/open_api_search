require 'rails_helper'

RSpec.feature "User can search" do
  scenario "by character name" do
    VCR.use_cassette('full_name', :match_requests_on => [:host]) do

    visit '/'

    fill_in 'name', with: 'wolverine'

    click_on 'Search'

    expect(current_path).to eq('/search')

    expect(page).to have_content('Wolverine')
    expect(page).to have_content('')
    expect(page).to have_content('')
    end
  end
end
