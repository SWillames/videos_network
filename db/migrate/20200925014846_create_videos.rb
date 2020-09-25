class CreateVideos < ActiveRecord::Migration[6.0]
  def change
    create_table :videos do |t|
      t.string :title
      t.string :url
      t.string :tag
      t.string :tag1
      t.string :tag2
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
