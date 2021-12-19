module CommentsHelper
  def _set_post(post)
    return unless params[:post]

    cookies[:current_post] = { value: post }
  end

  def clean_post_cookies
    cookies[:current_post] = nil
  end

  def post_set?
    !cookies[:current_post].nil?
  end

  def current_post=(post)
    @current_post = post
  end

  def current_post
    @current_post ||= Post.find_by_id cookies[:current_post]
  end
end
