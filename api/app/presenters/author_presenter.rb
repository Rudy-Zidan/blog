class AuthorPresenter < UserPresenter
  def initialize(author:)
    super(user: author)
  end
end