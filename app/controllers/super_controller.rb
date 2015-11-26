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

  def dashboard
    now_time = DateTime.now
    @events = Event.where(Event.arel_table[:start].lt(now_time).and(Event.arel_table[:end].gt(now_time))).all
  end

  def login
  end

  def logout
  end

  def project_list
    @projects = Project.all
  end

  def project_add

    if request.post? then
      ActiveRecord::Base.transaction do
        project_data = Project.new
        project_data.sales_user_id = params[:sales].to_i
        project_data.company_id = params[:company].to_i
        project_data.name = params[:name]
        project_data.url = params[:url]
        project_data.page_type = 1
        project_data.title = params[:title]
        project_data.description = params[:description]
        project_data.ogp_description = params[:ogp_description]
        project_data.start_at = params[:start_at]
        project_data.finish_at = params[:finish_at]
        project_data.save

        Event.create(:project_id => project_data[:id] ,:title => params[:name],:start => params[:start_at],:end => params[:finish_at])

      end
    end

  end

  def project_edit

    @project = Project.where(:id => params[:id]).first

    if request.post? then
      ActiveRecord::Base.transaction do
        @project.sales_user_id = params[:sales].to_i
        @project.company_id = params[:company].to_i
        @project.name = params[:name]
        @project.url = params[:url]
        @project.page_type = 1
        @project.title = params[:title]
        @project.description = params[:description]
        @project.ogp_description = params[:ogp_description]
        @project.start_at = params[:start_at]
        @project.finish_at = params[:finish_at]
        @project.save

        event_data       = Event.where(:project_id => params[:id]).first
        event_data.title = params[:name]
        event_data.start = params[:start_at]
        event_data.end   = params[:finish_at]
        event_data.save
      end
    end

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
    @companies = Company.all
  end

  def company_add
    if request.post? then
      if Company.regist(params[:name],params[:description],params[:password],params[:email],params[:password_confirm]) then
      end
    end
  end

  def company_edit
  end

  def company_delete
  end

  def admin_list
    @admins = Admin.all
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

  def task_list
    @tasks = Task.where(:finish_at => nil).all
  end

  def task_add
    if request.post? then
      task_data = Task.new
      task_data.admin_id = params[:admin_id]
      task_data.title = params[:title]
      task_data.context = params[:context]
      task_data.state = params[:state]
      task_data.save
    end
  end

  def task_delete
  end

  def task_delete
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
