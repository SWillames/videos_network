class News < ApplicationRecord
  belongs_to :user
  validates_presence_of :title, :slug, :introduction, :tldr, :body, :url_image, :tag, :tag1, :tag2
end
