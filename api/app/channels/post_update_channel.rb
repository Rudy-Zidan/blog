class PostUpdateChannel < ApplicationCable::Channel
  def subscribed
    stream_for "post_#{params[:id]}"
  end
end
