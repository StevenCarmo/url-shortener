class LongLink < ActiveRecord::Base

  has_one :short_link

  validate :must_be_valid_url
  validates :url,
    presence: true,
    uniqueness: {case_sensitive: true , message: "Url is not unique"},
    if: :continue_validation?

  def must_be_valid_url
    errors.add(:base, 'Url is invalid') unless valid_url?
  end

  def valid_url?
    # TODO tighten validation
    url = URI.parse(self.url) rescue false
    return url.kind_of?(URI::HTTP) || url.kind_of?(URI::HTTPS)   
  end

  private

  def continue_validation? #need to test
    true if errors.count == 0
  end

end
