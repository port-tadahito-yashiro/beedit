class AdminController < ApplicationController

  def list
    @admins = Admin.all
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
  end

end
