require 'database_cleaner'
require "rails_helper"

describe ShortLink, :type => :model do
  subject { FactoryGirl.build(:short_link) }
  
  it "has a valid factory" do
    expect(subject).to be_valid
  end

  describe "#create" do
    it 'returns a ShortLink' do
      expect(subject.class.to_s).to eq "ShortLink"
    end

    it "requires a long_link_id" do
      expect(FactoryGirl.build(:short_link, :long_link_id => nil)).to be_invalid
    end

    it "requires a related LongLink record" do
      @long_link = FactoryGirl.create(:long_link)
      expect(FactoryGirl.create(:short_link, :long_link_id => @long_link.id)).to be_valid
    end

    it "slug is required" do
      expect(FactoryGirl.build(:short_link, :slug => nil)).to be_invalid
    end

    it "length must be equal to LENGTH" do
      subject { FactoryGirl.build(:short_link) }
      subject.slug = "A" * ShortLink::LENGTH
      
      expect(subject).to be_valid
    end
   
  end
  
end