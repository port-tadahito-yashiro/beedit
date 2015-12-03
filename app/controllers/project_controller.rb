require 'json'
require 'uri'
require 'net/http'
require 'csv'

include Beedit_api

#定数
BEEDIT_API_URL = ("http://localhost:3001/api/stage.json")

class ProjectController < ApplicationController


  #
  # list
  # Author kazuki.yamaguchi
  # Created 2015/12/03
  #
  def list
    @projects = Project.where(:deleted_at => nil).all
  end

  #
  # add
  # Author kazuki.yamaguchi
  # Created 2015/12/03
  #
  def add

    @saleses = Admin.where(:department_id => 1).all
    @companies = Company.all

    if request.post? then
      ActiveRecord::Base.transaction do
        @project = Project.new
        @project.sales_user_id = params[:sales].to_i
        @project.company_id = params[:company].to_i
        @project.name = params[:name]
        @project.table_name = params[:table_name]
        @project.url = params[:url]
        @project.page_type = 1
        @project.title = params[:title]
        @project.description = params[:description]
        @project.ogp_description = params[:ogp_description]
        @project.start_at = params[:start_at]
        @project.finish_at = params[:finish_at]
        @project.domain_name = params[:domain_name]
        @project.deadline_at = params[:deadline_at]
        if @project.save then
          notify_to_slack_project
        end
        Event.create(:project_id => @project[:id] ,:title => params[:name],:start => params[:start_at],:end => params[:finish_at])
      end
    end

  end

  #
  # edit
  # Author kazuki.yamaguchi
  # Created 2015/12/03
  #
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
        @project.table_name = params[:table_name]
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

  #
  # delete
  # Author kazuki.yamaguchi
  # Created 2015/12/03
  #
  def delete
    project = Project.where(:id => params[:id]).first
    project.deleted_at = Time.now
    project.deleted_time = Time.now.to_i
    project.deleted_user = 1
    if project.save then
      p "成功した"
    end
    redirect_to :controller => 'project', :action => 'list'
  end

  #
  #
  # Author kazuki.yamaguchi
  # Created
  #
  #
  def delete_list
  end

  #
  #
  # Author kazuki.yamaguchi
  # Created
  #
  #
  def delete_restore
  end

  #
  #
  # Author kazuki.yamaguchi
  # Created
  #
  #
  def graph
  end

  #
  # user
  # Author kazuki.yamaguchi
  # Created 2015/12/03
  #
  #
  def user

    tabele_name = Project.where(:id => params[:id]).first
    #apiは"/models/concerns/beedit_api"にあります
    result = Beedit_api.api(BEEDIT_API_URL,"table_name=#{tabele_name.table_name}")

    p "--------------"
    p result
    p ">>>>>>>>>>>>>"

    @records = result

    respond_to do |format|
      format.html
      #foramt.csv { send_data to_csv(result) ,type: 'data/csv; charset=shift_jis', filename: "顧客データ.csv"}
    end
  end

  private


  #
  # to_csv(data)
  # Author kazuki.yamaguchi
  # Created 2015/12/03
  # データをCSVに適切な形に整形
  #
  def to_csv(data)
    CSV.generate do |csv|
      data.first(1).each do |key|
        csv << key.keys
      end
      data.each do |value|
        csv << value.values
      end
    end
  end


  #
  # notify_to_slack_project
  # Author kazuki.yamaguchi
  # Created 2015/12/02
  #　slackに新規プロジェクト作成の通知
  #
  def notify_to_slack_project
    text = <<-EOC
    -----------------------------

    新規でプロジェクトが建てられました、
    確認してください。

    ▼プロジェクト名
    #{@project.name}

    ▼プロジェクトのタイトル
    #{@project.title}

    ▼プロジェクトdescription
    #{@project.description}

    ▼プロジェクトのURL
    #{@project.url}

    EOC

    Slack.chat_postMessage text: text, username: "Opinion Notifier", channel: "#general"
  end

end
