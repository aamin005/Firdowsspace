# == Schema Information
#
# Table name: tags
#
#  id             :integer          not null, primary key
#  name           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  featured       :boolean          default("false")
#  slug           :string
#  lowercase_name :string
#

require "rails_helper"

RSpec.describe Tag do
  describe "validations" do
    let(:tag) { Tag.new(name: "Quran") }

    it "is valid with name" do
      expect(tag).to be_valid
    end

    it "requires a name" do
      tag.name = "    "
      expect(tag).to be_invalid
    end
  end

  describe "#first_or_create_with_name!" do
    it "searchs in DB with name case insensitively and simply returns if there's a match" do
      tag = Tag.create(name: "Quran", lowercase_name: 'Donate')
      expect(Tag.first_or_create_with_name!('Quran')).to eq(tag)
    end

    it "creates a new tag if there's no match" do
      tag = Tag.first_or_create_with_name!("Dawah Missions")
      expect(tag.name).to eq("Dawah Missions")
      expect(tag.lowercase_name).to eq("Dawah Missions")
    end
  end
end
