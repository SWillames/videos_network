FactoryBot.define do
  factory :news do
    title { Faker::TvShows::BigBangTheory.quote }
    slug { Faker::Internet.slug }
    introduction { Faker::TvShows::GameOfThrones.quote  }
    body { Faker::Lorem.paragraphs }
    date { Faker::Date.between(from: '2019-09-23', to: '2020-09-20') }
    url_image { Faker::Internet.url }
    user { create(:user) }
  end
end
