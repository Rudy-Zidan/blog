class UpdatePostService < ApplicationService
  def initialize(post:, params:)
    @post = post
    @params = params
  end

  def run
    if @post.author_id != @params[:author_id]
      @post.errors.add(:author, "not authorized for this action")
      return @post
    end

    @post.update(@params)
    @post
  end
end