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

  scope :finish, ->{ where(finish_at: nil) }
  scope :finish_before, ->(time){ where(arel_table[:finish_at].gt(time)) }

  scope :state, ->{ where(state: 0) }
  scope :state_delete, ->{ where(state: 1) }

  scope :deleted, ->{ where(deleted_at: nil) }

  def self.regist(params, project = nil)
    task = Task.new
    task.project_id = project
    task.admin_id   = params[:user_id].to_i
    task.title      = params[:name]
    task.context    = params[:detail]
    task.state      = 0
    if task.save
      return true
    else
      return false
    end
  end
end
