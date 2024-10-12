require 'rails_helper'
# Spec for single page
# Custom routing
RSpec.describe 'Pages' do
  before do
    driven_by(:rack_test)
  end
  # create a published page
  let(:my_page) { create(:page, :published) }
  # spec
  it 'renders page' do
    visit page_path(slug: my_page.slug) # visit the page's URL
    article = find('article') # find article element on the page

    within article do # scope our expectation to only the article element and its content
      expect(page).to have_css('h2', text: my_page.title)
    end
  end
end
