class LongLink < ActiveRecord::Base

  has_one :short_link

  validate :must_be_valid_url
  validates :url,
    presence: true,
    uniqueness: {case_sensitive: true , message: "Url is not unique"},
    if: :continue_validation?

  # after_create :create_short_link
  before_destroy :destroy_short_links

  def must_be_valid_url
    errors.add(:base, 'Url is invalid') unless valid_url?
  end

  def valid_url?
    # TODO tighten validation
    url = URI.parse(self.url) rescue false
    return url.kind_of?(URI::HTTP) || url.kind_of?(URI::HTTPS)   
  end

  def self.find_or_create_by_url(url)
    return self.find_by_url(url) || self.create({url: url})
  end

  def short_link
    ShortLink.find_by_long_link_id(id)
  end

  # def create_short_link
  #   ShortLink.create({long_link_id: self.id})
  # end

  def destroy_short_links
    ShortLink.find_by_long_link_id(id).destroy
  end

  private

  def continue_validation? #need to test
    true if errors.count == 0
  end

end
