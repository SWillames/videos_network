class Video < ApplicationRecord
  belongs_to :user
  validates_presence_of :title, :url, :tag, :tag1, :tag2
end
