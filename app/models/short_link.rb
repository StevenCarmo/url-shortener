class ShortLink < ActiveRecord::Base

  LENGTH = 6

  belongs_to  :long_link, :inverse_of => :short_link

  validates   :long_link_id, presence: true, uniqueness: true
  validates   :slug, length: {maximum: LENGTH, minimum: LENGTH}
  validates   :slug, presence: true, uniqueness: true

end
