require 'rails_helper'

RSpec.describe 'Home', js: true do
  before do
    driven_by(:rack_test)
  end
  it 'renders homepage' do
    create(:page, :published)
    visit root_path

    within 'header' do
      expect(page).to have_link('My Blog')
    end

    articles = find_all('article') # find all <article> elements on the page
    expect(articles.size).to eq(1) # checking that there's only one article element

    within articles.first do # scope our expectaion down to first article element
      expect(page).to have_css('h2', text: Page.last.title) # check that it has an h2 element with the text of the last Page record's title attribute
    end
  end
end
