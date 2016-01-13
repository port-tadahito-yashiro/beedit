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
          Event.regist(params[:project], @project)
          # 新規タスクの作成
          unless params[:tasks].blank?
            params[:tasks].each do |task|
              unless task[1][:name].blank?
                if Task.regist(task[1], @project.id)
                  flash[:notice] = '新規タスクを作成しました'
                else
                  flash[:error] = '新規タスクの作成に失敗しました'
                  render json: { succces: false, id: project.id}
                end
              end
            end
          end
        end
        render json: { success: true, id: @project.id }
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
      if project = Project.update(params[:project], params[:id])
        flash[:notice] = 'プロジェクト情報を編集しました'
      else
        flash[:error] = 'プロジェクト情報の編集に失敗しました'
        render json: { success: false, id: project.id }
      end

      if event = Event.update(params[:project],params[:id])
        flash[:notice] = 'プロジェクト情報を編集しました'
      else
        flash[:error] = 'プロジェクト情報を編集に失敗しました'
        render json: { success: false, id: project.id }
      end

      return if params[:tasks].blank?
      # 新規タスクの作成
      unless params[:tasks].blank?
        params[:tasks].each do |task|
          unless task[1][:name].blank?
            if Task.regist(task[1], @project.id)
              flash[:notice] = '新規タスクを作成しました'
            else
              flash[:error] = '新規タスクの作成に失敗しました'
              render json: { succces: false, id: @project.id }
            end
          end
        end
      end
      render json: { success: true, id: @project.id }
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
        project.events.each do |event|
          event.deleted_at = Time.now
          event.deleted_time = Time.now.to_i
          event.deleted_user = 1
          unless event.save
            flash[:error] = 'プロジェクトのイベント削除に失敗しました'
            render json: { success: false }
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
