class TaskController < ApplicationController

  #未ログインの場合はログイン画面へ移動
  before_action :authenticate

  #
  # list
  # Author kazuki.yamaguchi
  # Created 2015/12/03
  #
  #
  def list
    now_time = DateTime.now
    @tasks = Task.where(:finish_at => nil,:deleted_at => nil).all
    @deleteTasks = Task.where(Task.arel_table[:finish_at].gt(now_time).or(Task.arel_table[:deleted_at].not_eq(nil))).all
  end

  #
  # add
  # Author kazuki.yamaguchi
  # Created 2015/12/03
  #
  #
  def add

    @Admins = Admin.all

    if request.post? then
      @task_data = Task.new
      @task_data.admin_id = params[:admin_id]
      @task_data.title = params[:title]
      @task_data.context = params[:context]
      @task_data.state = params[:state]
      if @task_data.save then
        p @task_data
        #notify_to_slack_task
      end
    end
  end

  #
  # delete
  # Author kazuki.yamaguchi
  # Created 2015/12/03
  #
  #
  def delete
    task = Task.where(:id => params[:id]).first
    p task
    task.deleted_at = Time.now
    task.deleted_time = Time.now.to_i
    task.deleted_user = 1
    if task.save then
      flash[:notice] = 'プロジェクトを削除しました'
      redirect_to(url_for({:controller => 'task',:action => 'list'}))
    end
  end

  private

  #
  # slackメッセージ(task)
  # Author kazuki.yamaguchi
  #
  #
  def notify_to_slack_task
    text = <<-EOC
    -----------------------------

    新しくタスクが追加されました。

    ▼タスクタイトル
    #{@task_data.title}
    ▼内容
    #{@task_data.context}


    EOC

    Slack.chat_postMessage text: text, username: "Opinion Notifier", channel: "#general"
  end

end
