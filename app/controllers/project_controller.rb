class ProjectController < ApplicationController


  def list
    @projects = Project.all
  end

  def add

    @saleses = Admin.where(:department_id => 1).all
    @companies = Company.all

    if request.post? then
      ActiveRecord::Base.transaction do
        @project_data = Project.new
        @project_data.sales_user_id = params[:sales].to_i
        @project_data.company_id = params[:company].to_i
        @project_data.name = params[:name]
        @project_data.url = params[:url]
        @project_data.page_type = 1
        @project_data.title = params[:title]
        @project_data.description = params[:description]
        @project_data.ogp_description = params[:ogp_description]
        @project_data.start_at = params[:start_at]
        @project_data.finish_at = params[:finish_at]
        if @project_data.save then
          notify_to_slack_project
        end
        Event.create(:project_id => @project_data[:id] ,:title => params[:name],:start => params[:start_at],:end => params[:finish_at])
      end
    end

  end

  def edit

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

  def delete
  end

  def delete_list
  end

  def delete_restore
  end

  def project_graph
  end

  private


  def notify_to_slack_project
    text = <<-EOC
    -----------------------------

    新規でプロジェクトが建てられました、
    確認してください。

    ▼プロジェクト名
    #{@project_data.name}

    ▼プロジェクトのタイトル
    #{@project_data.title}

    ▼プロジェクトdescription
    #{@project_data.description}

    ▼プロジェクトのURL
    #{@project_data.url}


    EOC

    Slack.chat_postMessage text: text, username: "Opinion Notifier", channel: "#general"
  end

end
