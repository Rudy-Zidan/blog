class PostUpdateChannel < ApplicationCable::Channel
  def subscribed
    stream_from "post_update"
  end
end
