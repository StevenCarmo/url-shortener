class ShortLink < ActiveRecord::Base
  
  belongs_to  :long_link, :inverse_of => :short_link

end
