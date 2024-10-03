require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  # check if user instance is valid
  it 'has a valid factory' do
    expect(user).to be_valid
  end

  # field validation
  describe 'validations' do
    # validate_presence_of and validate_uniqueness_of are from soulda-matchers
    # validation spec for name
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }

    # validation spec for email
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email) }

    # email sanity checks
    it { is_expected.to_not allow_value('foo@').for(:email) }
    it { is_expected.to_not allow_value('@bar.com').for(:email) }
  end
end
