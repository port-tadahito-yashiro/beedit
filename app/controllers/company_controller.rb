class CompanyController < ApplicationController

  #
  # list
  # Author kazuki.yamaguchi
  # Created 2015/12/03
  #
  def list
    @companies = Company.where(:deleted_at => nil).all
  end

  #
  # add
  # Author kazuki.yamaguchi
  # Created 2015/12/03
  #
  def add
    if request.post? then
      if Company.regist(params[:name],params[:description],params[:password],params[:email],params[:password_confirm]) then
        flash[:notice] = '新規 企業情報を作成しました'
        redirect_to(url_for({:controller => 'super',:action => 'dashboard'}))
      end
    end
  end

  #
  # edit
  # Author kazuki.yamaguchi
  # Created 2015/12/03
  #
  def edit
    @projects = Project.where(:company_id => params[:id]).all
    @company = Company.where(:id => params[:id]).first
    if request.post?
      if Company.updated(params[:id],params[:name],params[:description],params[:password],params[:email],params[:password_confirm]) then
        flash[:notice] = '企業情報を編集しました'
        redirect_to(url_for({:controller => 'super',:action => 'dashboard'}))
      end
    end
  end

  #
  # delete
  # Author kazuki.yamaguchi
  # Created 2015/12/03
  #
  def delete
    company = Company.where(:id => params[:id]).first
    company.deleted_at = Time.now
    company.deleted_time = Time.now.to_i
    company.deleted_user = 1
    if company.save then
      flash[:notice] = '企業情報を削除しました'
      return redirect_to(url_for({:controller => "company",:action => "list"}))
    end
  end

end
