class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.references :user, foreign_key: true, index: true
      t.references :post, foreign_key: true, index: true
      t.string :content, nil: false
      t.bigint :like_reactions_count, default: 0
      t.bigint :smile_reactions_count, default: 0
      t.bigint :thumbs_up_reactions_count, default: 0
      t.timestamps
    end
  end
end
