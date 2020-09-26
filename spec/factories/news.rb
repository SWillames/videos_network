require 'ffaker'

FactoryBot.define do
  factory :news do
    title { FFaker::Movie.title }
    slug { FFaker::Internet.slug }
    tldr { FFaker::Lorem.phrase }
    introduction { FFaker::Lorem.sentence  }
    body { FFaker::Lorem.paragraphs }
    date { FFaker::Time.between('2019-09-23', '2020-09-20') }
    url_image { FFaker::Internet.uri('vide.m3u8') }
    tag {'#'+ FFaker::Lorem.word}
    tag1 {'#'+ FFaker::Lorem.word}
    tag2 {'#'+ FFaker::Lorem.word}
    user { create(:user) }
  end
end
