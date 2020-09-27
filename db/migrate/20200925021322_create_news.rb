class CreateNews < ActiveRecord::Migration[6.0]
  def change
    create_table :news do |t|
      t.string :title
      t.string :slug
      t.text :tldr
      t.text :introduction
      t.text :body
      t.date :date
      t.string :url_image
      t.string :tag
      t.string :tag1
      t.string :tag2
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
