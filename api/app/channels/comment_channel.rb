class CommentChannel < ApplicationCable::Channel
  def subscribed
    stream_from "post"
  end
end
