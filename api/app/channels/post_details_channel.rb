class PostDetailsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "post_details_#{params[:id]}"
  end
end
