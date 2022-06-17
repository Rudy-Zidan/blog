class CommentPresenter < ApplicationPresenter
  def initialize(comment:)
    @comment = comment
  end

  def present
    {
      id: @comment.id,
      content: @comment.content,
      user: {
        id: @comment.user_id,
        name: @comment.user_name,
      },
      reaction_summary: {
        likes: @comment.like_reactions_count,
        smiles: @comment.smile_reactions_count,
        thumbs_up: @comment.thumbs_up_reactions_count,
      },
      reactions: @comment.comment_reactions.map do |comment_reaction|
        CommentReactionPresenter.new(comment_reaction: comment_reaction).present
      end,
      created_at: @comment.created_at
    }
  end
end