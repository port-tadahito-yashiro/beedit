require 'time'

class SuperController < ApplicationController

  #
  # ログイン画面
  # Author:: kazuki.yamaguchi
  # Create::
  #
  def index
    #ログイン認証
    if request.post? then
      super_user = Admin.authenticate(params[:super][:email],params[:super][:password])
      if !super_user.blank? then
        session[:super_user_id] = super_user[:id]
        return  redirect_to url_for({:controller => 'super',:action => 'index'})
      end
    end
  end

  #
  # dashboard
  # Author kazuki.yamaguchi
  # Created 2015/12/03
  #
  #
  def dashboard
    @Cproject = Project.all.count
    p @Cproject
    now_time = DateTime.now
    @events = Event.where(Event.arel_table[:start].lt(now_time).and(Event.arel_table[:end].gt(now_time)).and(Event.arel_table[:deleted_at].eq(nil))).all
  end

  #
  # login
  # Author kazuki.yamaguchi
  # Created 2015/12/03
  #
  #
  def login
  end

  #
  # logout
  # Author kazuki.yamaguchi
  # Created 2015/12/03
  #
  #
  def logout
  end

  private

  #
  # authenticatedSuperId
  # Author kazuki.yamaguchi
  #
  #
  def authenticatedSuperId


  end

end
