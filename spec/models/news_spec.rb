require 'rails_helper'

RSpec.describe News, type: :model do
  context "testing validations" do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:tldr) }
    it {is_expected.to validate_presence_of(:slug)}
    it {is_expected.to validate_presence_of(:introduction)}
    it {is_expected.to validate_presence_of(:body)}
    it {is_expected.to validate_presence_of(:url_image)}
    it {is_expected.to validate_presence_of(:tag)}
    it {is_expected.to validate_presence_of(:tag1)}
    it {is_expected.to validate_presence_of(:tag2)}
  end
  
  
  context "testing associations" do
    it { is_expected.to belong_to(:user) } 
  end
end
