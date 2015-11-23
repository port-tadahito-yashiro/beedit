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

  def dashboard
  end

  def login
  end

  def logout
  end

  def project_list
    @projects = Project.all
  end

  def project_add
  end

  def project_edit
  end

  def project_delete
  end

  def project_delete_list
  end

  def project_delete_restore
  end

  def project_graph
  end

  def company_list
  end

  def company_add
  end

  def company_edit
  end

  def company_delete
  end

  def admin_list
  end

  def admin_add
    if request.post? then
      if Admin.regist(params[:name],params[:email],params[:password],params[:password_confirm]) then
      end
    end
  end

  def admin_edit
  end

  def admin_delete
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
