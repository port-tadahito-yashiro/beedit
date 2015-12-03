class AdminController < ApplicationController

  def list
    @admins = Admin.where(:deleted_at => nil).all
  end

  def add
    @departments = Department.all
    if request.post? then
      p "-------"
      p params[:department]
      if Admin.regist(params[:department],params[:name],params[:email],params[:password],params[:password_confirm]) then
      end
    end
  end

  def edit
    @admin = Admin.where(:id => params[:id]).first
    @departments = Department.all
    if request.post?
      if Admin.updated(params[:id],params[:department],params[:name],params[:email],params[:password],params[:password_confirm]) then
        p "リダイレクト"
        redirect_to(url_for({:controller => 'super',:action => 'dashboard'}))
      end
    end
  end

  def delete
    admin = Admin.where(:id => params[:id]).first
    admin.deleted_at = Time.now
    admin.deleted_time = Time.now.to_i
    admin.deleted_user = 1
    if admin.save then
      "成功した"
    end
    redirect_to :controller => "admin",:action => "list"
  end

end
