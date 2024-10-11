class Page < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, uniqueness: true
  validates :content, presence: true
  scope :published, -> { where(published: true) }

  before_validation :make_slug

  private

  def make_slug
    return if title.blank? # Skip slug generation if title is nil
    self.slug = title
                  .downcase
                  .gsub(/[_ ]/, '-') # rubocop:disable Style/StringLiterals
                  .gsub(/[^-a-z0-9+]/, '') # rubocop:disable Style/StringLiterals
                  .gsub(/-{2,}/, '-') # rubocop:disable Style/StringLiterals
                  .gsub(/^-/, '') # rubocop:disable Style/StringLiterals
                  .chomp('-') # rubocop:disable Style/StringLiterals
  end
end
