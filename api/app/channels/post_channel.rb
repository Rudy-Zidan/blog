class PostChannel < ApplicationCable::Channel
  def subscribed
    stream_from "post"
  end
end
