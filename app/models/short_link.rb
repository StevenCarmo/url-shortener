class ShortLink < ActiveRecord::Base

  LENGTH = 6
  CHARACTER_SET = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'.split('')
  CHARACTERS = Hash[CHARACTER_SET.map.with_index { |x, i| [x, i] }]

  belongs_to  :long_link
  
  validates   :slug, length: {maximum: LENGTH, minimum: LENGTH}
  validates   :slug, presence: true, uniqueness: true
  validates   :long_link_id, presence: true, uniqueness: true
  validate    :validate_by_slug_suffix
  validate    :validate_long_link

  before_validation :generate_slug!, if: :new_record?

  def generate_slug!
    self.slug = ''
    slug_sum = 0

    (1...LENGTH).each do
      random = Random.rand(CHARACTER_SET.length)
      slug_sum += random
      self.slug += CHARACTERS.key(random).to_s
    end

    self.slug += CHARACTERS.key(slug_sum % CHARACTER_SET.length).to_s  
  end

  def validate_long_link 
    if self.long_link_id.nil? || LongLink.find_by_id(self.long_link_id).present? == false
      errors.add(:base, 'Long Link not present')
    end 
  end

  def validate_by_slug_suffix
    return false if slug.nil?
    slug_sum = 0
    
    slug_chars = slug.split('')
    slug_suffix = slug_chars.pop

    slug_chars.each{|v| slug_sum += CHARACTERS[v.to_s]}
    
    true if (slug_sum % CHARACTER_SET.length) == CHARACTERS[slug_suffix.to_s]  
  end

end
