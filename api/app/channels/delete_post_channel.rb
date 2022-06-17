class DeletePostChannel < ApplicationCable::Channel
  def subscribed
    stream_from "delete_post"
  end
end
