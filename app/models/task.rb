class Task < ActiveRecord::Base

  belongs_to :project
  belongs_to :admin

  before_save do
    self.created_at = Time.now
    self.created_time = Time.now.to_i
    self.created_user = 1
    self.updated_at = Time.now
    self.updated_time = Time.now.to_i
    self.updated_user = 1
  end

  before_update do
    self.updated_at = Time.now
    self.updated_time = Time.now.to_i
  end

  def self.regist(params, project)
    task = Task.new
    task.project_id = project[:id]
    task.admin_id   = params[:user_id].to_i
    task.title      = params[:name]
    task.context    = params[:detail]
    task.state      = 0
    return if task.save
  end
end
