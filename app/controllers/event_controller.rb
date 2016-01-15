require 'date'

class EventController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

 # GET /events
 # GET /events.json
 def index
   @events = Event.where(deleted_at: nil).all
 end

 # GET /events/1
 # GET /events/1.json
 def show
 end

 # GET /events/new
 def new
   @event = Event.new
 end

 # GET /events/1/edit
 def edit
 end

 # POST /event
 # POST /event.json
 def create

   if request.post?
     # データの保存
     event = Event.new
     event[:title] = params[:name]
     event[:start] = params[:start]
     event[:end]   = params[:end]
     event.save
   end
   data = []
   Event.where(:deleted_at => nil).all.each do |item|
     data.push(item)
   end
  render :json => ActiveSupport::JSON.encode(data)
 end

 # PATCH/PUT /events/1
 # PATCH/PUT /events/1.json
 #def update
  # respond_to do |format|
  #   if @event.update(event_params)
  #     format.html { redirect_to @event, notice: 'Event was successfully updated.' }
  #     format.json { render :show, status: :ok, location: @event }
  #   else
  #     format.html { render :edit }
  #     format.json { render json: @event.errors, status: :unprocessable_entity }
  #   end
   #end
  def update
    if request.post?
      # イベントデータ更新処理
      data = Event.where(:id => params[:id]).first
      data[:title] = params[:name]
      data[:start] = params[:start]
      data[:end]   = params[:end]
      data.save

      unless data[:project_id].blank?
        project = Project.where(:id => data[:project_id]).first
        project[:name]      = params[:name]
        project[:start_at]  = params[:start]
        project[:finish_at] = params[:end]
        project.save
      end
    end
    view_data = []
    Event.where(:deleted_at => nil).all.each do |item|
      view_data.push(item)
    end
   render :json => ActiveSupport::JSON.encode(view_data)
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def delete
    if request.post?
      event = Event.where(:id => params[:id]).last
      event[:deleted_at] = Time.now
      event[:deleted_time] = Time.now.to_i
      event[:deleted_user] = 1
      event.save
    end
    data = []
    Event.where(:deleted_at => nil).all.each do |item|
      data.push(item)
    end
   render :json => ActiveSupport::JSON.encode(data)
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

end
