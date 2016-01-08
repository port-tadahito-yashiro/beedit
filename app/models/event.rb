class Event < ActiveRecord::Base
  belongs_to :project

  def self.regist(params, project)
    event = Event.new
    event.project_id = project[:id]
    event.title = params[:name]
    event.start = params[:start_at]
    event.end   = params[:finish_at]
    return if event.save
  end

end
