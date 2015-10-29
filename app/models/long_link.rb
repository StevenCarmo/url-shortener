class LongLink < ActiveRecord::Base

  has_one :short_link, :inverse_of => :long_link

end
