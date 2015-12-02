class TaskController < ApplicationController

  def list
    @tasks = Task.where(:finish_at => nil).all
  end

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
        notify_to_slack_task
      end
    end
  end

  def delete
  end

  def delete
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
