require 'database_cleaner'
require "rails_helper"

describe ShortLink, :type => :model do
  subject { FactoryGirl.build(:short_link) }
  
  it "has a valid factory" do
    expect(subject).to be_valid
  end

  
end