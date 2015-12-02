class CompanyController < ApplicationController

  def list
    @companies = Company.all
  end

  def add
    if request.post? then
      if Company.regist(params[:name],params[:description],params[:password],params[:email],params[:password_confirm]) then
      end
    end
  end

  def edit
    @projects = Project.where(:company_id => params[:id]).all
  end

  def delete
  end

end
