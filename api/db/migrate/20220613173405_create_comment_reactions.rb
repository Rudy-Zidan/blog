class CreateCommentReactions < ActiveRecord::Migration[7.0]
  def change
    create_table :comment_reactions do |t|
      t.references :comment, foreign_key: { on_delete: :cascade }, index: true
      t.references :user, foreign_key: true, index: true
      t.string :type
      t.timestamps
    end

    add_index :comment_reactions, [:type, :comment_id, :user_id], unique: true
  end
end
