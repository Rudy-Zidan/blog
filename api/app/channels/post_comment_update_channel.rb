class PostCommentUpdateChannel < ApplicationCable::Channel
  def subscribed
    stream_from "post_comment_update_#{params[:post_id]}"
  end
end
