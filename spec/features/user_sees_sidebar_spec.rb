require 'rails_helper'

RSpec.feature "User sees sidebar" do
  let! (:search) { create_list(:search, 3) }

  scenario "with previous searches" do
    visit '/'
save_and_open_page
    expect(page).to have_content('Previous Searches')
    expect(page).to have_link('cyclops 1')
    expect(page).to have_css('ul li p', :text => 'search count: 1', :count=> 3)
    expect(page).to have_link('cyclops 2')
    expect(page).to have_link('cyclops 3')
  end
end
