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

  describe "#validate_by_slug" do
    subject { build(:short_link) }

    it 'validates against last character (checksum)' do
      subject.slug = 'aaaaaa'
      expect(subject.validate_slug_suffix).to eq true
      subject.slug = 'aaaaab'
      expect(subject.validate_slug_suffix).not_to eq true
    end
   
  end

  describe "#find_by_slug_assisted" do
    subject { create(:short_link, :slug => 'AyVaOn') }

    context "short_link record with slug AyVaOn" do
      it 'replaces 0 with O' do
        expect(subject.slug).to eq "AyVaOn"
        expect(ShortLink.find_by_slug_assisted('AyVa0n')).to be_an_instance_of(ShortLink) 
      end
    end
  end
  
end