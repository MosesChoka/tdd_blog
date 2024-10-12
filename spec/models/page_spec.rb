require 'rails_helper'

RSpec.describe Page, type: :model do
  subject { build(:page) }

  # validations
  describe 'validations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to be_valid }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_uniqueness_of(:title) }
    it { is_expected.to validate_presence_of(:content) }
  end

  # slug
  describe '#slug' do
    let(:page) { create(:page, title: '--Foo Bar! _ 87 --') }

    it 'is generated from the title' do
      expect(page.slug).to eq('foo-bar-87')
    end
  end

  # spec to display only published pages
  describe 'scopes' do
    describe '.published' do
      let(:page1) { create(:page, :published) }
      let(:page2) { create(:page) }

      # RSpec lets are lazily evaluated, so we use before block to create both records in our database before our spec runs
      before do
        [ page1, page2 ]
      end

      it 'returns only published pages' do
        expect(Page.published).to eq([ page1 ])
      end
    end
  end
end
