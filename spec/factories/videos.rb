FactoryBot.define do
  factory :video do
    title { Faker::Movie.quote }
    url { 'https://content.jwplatform.com/manifests/yp34SRmf.m3u8' }
    tag { "MyString" }
    tag1 { "MyString" }
    tag2 { "MyString" }
    user { create(:user) }
  end
end
