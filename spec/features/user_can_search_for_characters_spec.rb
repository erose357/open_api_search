require 'rails_helper'

RSpec.feature "User can search" do
  scenario "by character full name" do
    VCR.use_cassette('full_name', :match_requests_on => [:host]) do

    visit '/'

    fill_in 'name', with: 'wolverine'

    click_on 'Search'

    expect(current_path).to eq('/search')

    expect(page).to have_content('Wolverine')
    expect(page).to have_content('Born with super-human senses and the power to heal from almost any wound')
    expect(page).to have_css("img[src='http://i.annihil.us/u/prod/marvel/i/mg/2/60/537bcaef0f6cf.jpg']")
    expect(page).to have_content('Wolverine (Ultimate)')
    expect(page).to have_content('Decades after participating in military airdrops with Captain America during WWII')
    expect(page).to have_css("img[src='http://i.annihil.us/u/prod/marvel/i/mg/9/03/531773b76840c.jpg']")
    end
  end
end
