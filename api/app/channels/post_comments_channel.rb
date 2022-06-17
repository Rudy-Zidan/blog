class PostCommentsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "post_comments_#{params[:post_id]}"
  end
end
