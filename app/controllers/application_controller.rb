class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  load_and_authorize_resource

  #before_filter do
  #  resource = controller_name.singularize.to_sym
  #  method = "#{resource}_params"
  #  params[resource] &&= send(method) if respond_to?(method, true)
  #end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = '権限がありません'
    redirect_to(url_for({ controller: 'super', action: 'dashboard' }))
  end

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

  def current_ability
    current_user = Admin.where(id: session[:adminId]).last
    @current_ability ||= Ability.new(current_user)
  end
end
