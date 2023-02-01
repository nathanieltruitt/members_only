module PostsHelper
  def auth_user
    authenticate_user
  end
end