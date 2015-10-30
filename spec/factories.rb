FactoryGirl.define do

  factory :long_link do
    url                   "http://www.google.com"
  end

  factory :short_link do
    long_link
    slug                   "AAAAAA"
  end

end