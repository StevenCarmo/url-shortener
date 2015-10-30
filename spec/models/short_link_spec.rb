require 'database_cleaner'
require "rails_helper"

describe ShortLink, :type => :model do
  # subject {  }
  
  it "has a valid factory" do
    expect(build(:short_link)).to be_valid
  end

  describe "#create" do
    it 'returns a ShortLink' do
      expect(subject.class.to_s).to eq "ShortLink"
    end

    it "requires a valid long_link_id" do
      expect(build(:short_link, :long_link_id => 30000)).to be_invalid
    end

    it "generates slug is if nil or invalid" do
      expect(build(:short_link, :slug => nil)).to be_valid
    end
   
  end

  describe "#validate_by_slug_suffix" do
    subject { build(:short_link) }

    it 'validates against last character' do
      subject.slug = 'aaaaaa'
      expect(subject.validate_by_slug_suffix).to eq true
      subject.slug = 'aaaaab'
      expect(subject.validate_by_slug_suffix).not_to eq true
    end
   
  end
  
end