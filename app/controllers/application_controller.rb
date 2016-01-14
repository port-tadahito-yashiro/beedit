class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def logged_in?
    return !!session[:adminId]
  end

  #
  # authenticate
  # Author kazuki.yamaguchi
  # Created 
  # 未ログインの場合ログインを促す
  def authenticate
    return if logged_in?
    flash[:error] = 'ログインしてください'
    redirect_to url_for({ controller: 'super', action: 'index' })
  end
end
