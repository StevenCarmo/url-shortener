require 'database_cleaner'
require "rails_helper"

describe LongLink, :type => :model do
  subject { FactoryGirl.build(:long_link) }
  
  it "has a valid factory" do
    expect(subject).to be_valid
  end

  describe "#create" do
    it 'returns a LongLink' do
      expect(subject.class.to_s).to eq "LongLink"
    end

    it "requires a valid url" do
      expect(FactoryGirl.build(:long_link, :url => "htp://wwwo")).to be_invalid
    end

    it "requires a unique url" do
      FactoryGirl.create(:long_link)
      expect(FactoryGirl.build(:long_link)).to be_invalid
    end    
  end

  describe "#valid_url?" do
    subject { FactoryGirl.build(:long_link) }

    it "returns false for invalid urls" do
      subject.url = 'fdsafsa'
      expect(subject.valid_url?).to eq false
    end

    it "returns true for valid urls" do
      subject.url = 'http://www.google.com'
      expect(subject.valid_url?).to eq true 
    end

  end

end