class Event < ActiveRecord::Base
  belongs_to :project

  def self.regist(params, project)
    event = Event.new
    event[:project_id] = project[:id]
    event[:title]      = params[:name]
    event[:start]      = params[:start_at]
    event[:end]        = params[:finish_at]
    return if event.save
  end

  def self.update(params, project_id = nil)
    event = Event.where(project_id: project_id).first
    event[:title] = params[:name]
    event[:start] = params[:start_at]
    event[:end]   = params[:finish_at]
    if event.save
      return true
    else
      return false
    end
  end

end
