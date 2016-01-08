require 'json'
require 'uri'
require 'net/http'
require 'csv'
include Beedit_api
# 定数
BEEDIT_API_URL = ('http://localhost:3001/api/stage.json')

class ProjectController < ApplicationController
  # 未ログインの場合はログイン画面へ移動
  before_action :authenticate

  #
  # list
  # Author kazuki.yamaguchi
  # Created 2015/12/03
  #
  def list
    @projects = Project.where(deleted_at: nil).order('id DESC').page(params[:page]).per(15)
  end

  #
  # add
  # Author kazuki.yamaguchi
  # Created 2015/12/03
  #
  def add

    # select_tagで使う値を取得
    @saleses = Admin.where(department_id: 1).all
    @taskers = Admin.where(department_id: 1).all
    @companies = Company.all

    if request.post?
      # 値を取得する
      unless params[:project][:name].blank?
        ActiveRecord::Base.transaction do
          # 新規プロジェクトの作成
          @project = Project.regist(params[:project])
          flash[:notice] = '新しくプロジェクトを作成しました'
          # slackへの通知
          # notify_to_slack_project
          Event.regist(params[:tasks], @project)
          # 新規タスクの作成
          params[:tasks].each do |task|
            unless task[1][:name].blank?
              Task.regist(task[1], @project)
            end
          end
        end
        render json: { success: true, id: @project.id }
      else
        flash[:error] = '新しくプロジェクト作成に失敗しました'
        render json: { success: false }
      end
    end
  end

  #
  # edit
  # Author kazuki.yamaguchi
  # Created 2015/12/03
  #
  def edit
    # select_tagで使う値を取得
    @saleses = Admin.where(department_id: 1).all
    @taskers = Admin.where(department_id: 1).all
    @companies = Company.all

    @project = Project.where(id: params[:id]).first

    if request.post?
      # 値を取得する
      project_data = params[:project]
      task_data = params[:tasks]
      ActiveRecord::Base.transaction do
        @project.sales_user_id = project_data[:sales].to_i
        @project.company_id = project_data[:company].to_i
        @project.name = project_data[:name]
        @project.url = project_data[:url]
        @project.page_type = 1
        @project.title = project_data[:title]
        @project.table_name = project_data[:table_name]
        @project.description = project_data[:description]
        @project.ogp_description = project_data[:ogp_description]
        @project.start_at = project_data[:start_at]
        @project.finish_at = project_data[:finish_at]
        @project.domain_name = project_data[:domain_name]
        @project.domain_deadline_at = project_data[:domain_deadline_at]
        @project.ssl_deadline_at = project_data[:ssl_deadline_at]
        if @project.save
          flash[:notice] = 'プロジェクト情報を編集しました'
          event = Event.where(project_id: params[:id]).first
          event[:title] = project_data[:name]
          event[:start] = project_data[:start_at]
          event[:end]   = project_data[:finish_at]
          event.save
        else
          flash[:error] = 'プロジェクト情報の編集に失敗しました'
        end
        render json: { success: true,
                       id: @project.id }
      end
      return if task_data.blank?
        # 新規タスクの作成
      task_data.each_with_index do |task, i|
        unless task[1][:name].blank?
        Task.create(
                project_id: @project[:id].to_i,
                admin_id: task[1][:user_id].to_i,
                title: task[1][:name],
                context: task[1][:detail],
                state: '0')
        end
      end
    end
  end

  #
  # delete
  # Author kazuki.yamaguchi
  # Created 2015/12/03
  #
  def delete
    project = Project.where(id: params[:id]).first
    ActiveRecord::Base.transaction do
      project.deleted_at = Time.now
      project.deleted_time = Time.now.to_i
      project.deleted_user = 1
      if project.save
        ActiveRecord::Base.transaction do
          project.events.each do |event|
            event.deleted_at = Time.now
            event.deleted_time = Time.now.to_i
            event.deleted_user = 1
            event.save
          end
        end
        flash[:notice] = 'プロジェクトを削除しました'
        render json: { success: true }
      else
        flash[:error] = 'プロジェクトの削除に失敗しました'
        render json: { success: false }
      end
    end
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
    tabele_name = Project.where(id: params[:id]).first
    # apiは"/models/concerns/beedit_api"にあります
    result = Beedit_api.api(BEEDIT_API_URL,"table_name=#{tabele_name.table_name}")

    @id = params[:id]
    @records = result

    respond_to do |format|
      format.html
      format.csv { send_data to_csv(result),
                   type: 'data/csv; charset=shift_jis',
                   filename: tabele_name[:name] }
    end
  end

  def get_form
    render json: { 'data' => ProjectController.helpers.getTask }
  end


  private

  def tasks_params
      params.require(:task).permit(
        :project_id,
        :admin_id,
        :title,
        :context
      )
  end


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
  # slackに新規プロジェクト作成の通知
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
