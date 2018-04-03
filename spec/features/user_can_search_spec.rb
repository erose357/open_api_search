require 'rails_helper'

RSpec.feature "User can search" do
  scenario "for movies by movie title" do
    VCR.use_cassette('movies_search') do
      visit '/'

      fill_in 'title', with: 'fight club'

      click_on 'Search'

      expect(current_path).to eq(search_path)

      expect(page).to have_content('Fight Club')
      expect(page).to have_content("A ticking-time-bomb insomniac and a slippery soap salesman channel primal male aggression into a shocking new form of therapy. Their concept catches on, with underground \"fight clubs\" forming in every town, until an eccentric gets in the way and ignites an out-of-control spiral toward oblivion.")
      expect(page).to have_css('p.title', count: 18)
      expect(page).to have_css('p.overview', count: 18)
      expect(page).to have_css('p.release-date', count: 18)
    end
  end
end
