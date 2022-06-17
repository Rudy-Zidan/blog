class DeleteReactionChannel < ApplicationCable::Channel
  def subscribed
    stream_from "delete_reaction"
  end
end
