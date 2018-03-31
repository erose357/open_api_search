require 'rails_helper'

RSpec.feature "User can search" do
  scenario "by character name" do

    visit '/'

    fill_in 'name', with: 'deadpool'

    click_on 'Search'

    expect(current_path).to eq('/search')
    #I should see the name Wolverine, a description of the character, and a image of the character
    expect(page).to have_content('Wolverine')
    #expect(page).to have_content('') #need description info
    #expect(page).to have_content('') #need image path info
  end
end
