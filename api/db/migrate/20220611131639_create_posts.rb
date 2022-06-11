class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.references :user, foreign_key: true, index: true
      t.string :title, nil: false
      t.string :description, nil: false
      t.text :content, nil: false
      t.boolean :published, default: false, index: true
      t.timestamps
    end
  end
end
