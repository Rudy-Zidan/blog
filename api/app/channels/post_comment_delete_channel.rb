class PostCommentDeleteChannel < ApplicationCable::Channel
  def subscribed
    stream_from "post_comment_delete_#{params[:post_id]}"
  end
end
