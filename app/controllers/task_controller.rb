class TaskController < ApplicationController
  # 未ログインの場合はログイン画面へ移動
  before_action :authenticate

  #
  # list
  # Author kazuki.yamaguchi
  # Created 2015/12/03
  #
  #
  def list
    now_time = DateTime.now
    @tasks = Task.where(finish_at: nil,
                        deleted_at: nil,
                        state: 0).order('id DESC').page(params[:page]).per(15)
    @deleteTasks = Task.where(Task.arel_table[:finish_at].gt(now_time)
                              .or(Task.arel_table[:deleted_at].not_eq(nil))
                              .or(Task.arel_table[:state].not_eq(0))).order('deleted_at').limit(6)
  end

  #
  # add
  # Author kazuki.yamaguchi
  # Created 2015/12/03
  #
  #
  def add
    @admins = Admin.all
    @projects = Project.all
    if request.post?
      if Task.regist(params)
        flash[:notice] = 'タスクを作成しました'
        redirect_to(url_for({ controller: 'task', action: 'list' }))
        # notify_to_slack_task
      else
        flash[:error] = 'タスクの作成に失敗しました'
        redirect_to(url_for({ controller: 'task', action: 'list' }))
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
    task = Task.where(id: params[:id]).first
    task.deleted_at   = Time.now
    task.deleted_time = Time.now.to_i
    task.deleted_user = 1
    if task.save
      flash[:notice] = 'タスクを削除しました'
      redirect_to(url_for({ controller: 'task', action: 'list' }))
    else
      flash[:error] = 'タスクの削除に失敗しました'
      redirect_to(url_for({ controller: 'task', action: 'list' }))
    end
  end

  def edit
    @admins = Admin.all
    @task = Task.where(id: params[:id]).first
    @task.admin_id = params[:admin_id]
    @task.title = params[:title]
    @title.context = params[:context]
    if @task.save
      flash[:notice] = 'タスクを編集しました'
      redirect_to(url_for({ controller: 'task', action: 'list' }))
    else
      falsh[:error] = 'タスクの編集に失敗しました'
      redirect_to(url_for({ controller: 'task', action: 'edit', id: params[:id]}))
    end
  end

  def finish
    task = Task.where(id: params[:id]).first
    task.state = 1
    if task.save
      flash[:notice] = 'タスクを完了しました'
      redirect_to(url_for({ controller: 'task', action: 'list' }))
    else
      flash[:error] = 'エラーが起きました'
      redirect_to(url_for({ controller: 'task', action: 'list' }))
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
