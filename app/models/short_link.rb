class ShortLink < ActiveRecord::Base

  LENGTH = 6
  CHARACTER_SET = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'.split('')
  CHARACTERS = Hash[CHARACTER_SET.map.with_index { |x, i| [x, i] }]
  MISTYPED_CHARACTERS = ['o', '0'], ['O', '0'], ['0', 'O']

  OFFENSIVE_WORDS = ['foo','bar']
  OFFENSIVE_WORDS_TRIE = WordHash.build_trie(OFFENSIVE_WORDS)

  belongs_to  :long_link
  
  validates   :slug, length: {maximum: LENGTH, minimum: LENGTH}
  validates   :slug, presence: true, uniqueness: true
  validates   :long_link_id, presence: true, uniqueness: true
  validate    :validate_slug_suffix
  validate    :validate_long_link

  # before_validation :generate_slug!, if: :slug.length
  before_validation  do
    generate_slug! if self.slug.nil?
  end

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

  def validate_slug_suffix
    return false if ShortLink.valid_slug?(slug) == false
    return slug_is_clean?
  end

  def self.valid_slug?(slug=nil)
    return false if slug.nil?

    slug_sum = 0
    slug_chars = slug.split('')
    slug_suffix = slug_chars.pop

    slug_chars.each{|v| slug_sum += CHARACTERS[v.to_s]}
    
    return true if (slug_sum % CHARACTER_SET.length) == CHARACTERS[slug_suffix.to_s]
    return false 
  end

  def slug_is_clean?
    slug = self.slug.downcase.split('')
    res = true

    while slug.length >= 1 && res == true
      res = ShortLink.scan_slug(slug)
      slug.shift
    end

    return res
  end

  def self.scan_slug(slug)
    slug.each.inject(OFFENSIVE_WORDS_TRIE) do |h, key|
      return false if h.has_key?('value') == true
      return true if h.has_key?(key) == false && h.has_key?('value') == false
      h[key]
    end

    return false
  end

  def self.find_by_slug_assisted(slug)
    # Return record id found without assistance
    return self.find_by_slug(slug) if self.find_by_slug(slug).present?
    
    # Return record if assisted slug is valid and found
    slug_variation = nil

    MISTYPED_CHARACTERS.each do |mistake|
      if slug_variation.nil? && slug.include?(mistake[0].to_s)
        temp_slug = slug.sub(mistake[0].to_s, mistake[1].to_s)
        slug_variation = temp_slug if self.valid_slug?(temp_slug)
      end
    end

    return self.find_by_slug(slug_variation) if slug_variation.nil? == false
  end

end
