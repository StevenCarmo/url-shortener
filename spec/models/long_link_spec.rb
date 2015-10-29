require 'database_cleaner'
require "rails_helper"

describe LongLink, :type => :model do
  subject { FactoryGirl.build(:long_link) }
  
  it "has a valid factory" do
    expect(subject).to be_valid
  end

  
end