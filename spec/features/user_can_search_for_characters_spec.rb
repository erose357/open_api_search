require 'rails_helper'

RSpec.feature "User can search" do
  scenario "by character name" do
    #As a user
    #when i visit the root path
    visit '/'
    #And I fill in the search form with 'deadpool'
    fill_in 'Name', with: 'wolvervine'
    #And I click search
    click_on 'Search'
    #I should be on the page '/search' (maybe: with parameters visible in the url?)
    expect(current_path).to eq('/search')
    #I should see the name Wolverine, a description of the character, and a image of the character
    expect(page).to have_content('Wolverine')
    #expect(page).to have_content('') #need description info
    #expect(page).to have_content('') #need image path info
  end
end
