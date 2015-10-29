FactoryGirl.define do

  factory :long_link do
    url                   "http://www.google.com"
  end

  factory :short_link do
    slug                   "AAAAAA"
    long_link
  end

end