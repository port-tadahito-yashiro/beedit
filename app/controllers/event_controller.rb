require 'date'

class EventController < ApplicationController

  before_action :set_event, only: [:show, :edit, :update, :destroy]

 # GET /events
 # GET /events.json
 def index
   @events = Event.where(:deleted_at => nil).all
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
     #データの保存
     data = Event.new
     data[:title] = params[:event][:name]
     data[:start] = params[:event][:start]
     data[:end] = params[:event][:end]
     p "---------data.save------"
     p data
     data.save
   end
   view_data = []
   Event.where(:deleted_at => nil).all.each do |item|
     view_data.push(item)
   end
  render :json => ActiveSupport::JSON.encode(view_data)
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
    if request.put?
      p '------------------'
      data = Event.where(:id => params[:id]).last
      p "-----data----"
      p data
      data[:title]  = params[:event][:name]
      data[:start] = Time.at((params[:event][:start].to_i))
      data[:end] = Time.at((params[:event][:end].to_i))
      data.save
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
      p "-------デリート処理--------"
      data = Event.where(:id => params[:id]).last
      data[:deleted_at] = Time.now
      data[:deleted_time] = Time.now.to_i
      data[:deleted_user] = 1
      data.save
    end
    view_data = []
    Event.where(:deleted_at => nil).all.each do |item|
      view_data.push(item)
    end
   render :json => ActiveSupport::JSON.encode(view_data)
  end

 private
   # Use callbacks to share common setup or constraints between actions.
   def set_event
     @event = Event.find(params[:id])
   end

   # Never trust parameters from the scary internet, only allow the white list through.
   def event_params
     params.require(:event).permit(:name, :start, :end, :color, :allDay)
   end

end
