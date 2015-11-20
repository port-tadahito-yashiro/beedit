require 'date'

class EventController < ApplicationController

  before_action :set_event, only: [:show, :edit, :update, :destroy]

 # GET /events
 # GET /events.json
 def index
   @events = Event.all
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

 # POST /events
 # POST /events.json
 def create
   #data = Event.new
   #data[:name] = event_params[:name]

   #　受け取った値を数値にして変数へ
   #start_time = event_params[:start].to_i
   #finish_time = event_params[:end].to_i

   # Time関数でDATETIMEで変換してdataに入れる
   #data[:start_at] = Time.at(start_time)
   #data[:finish_at] = Time.at(finish_time)
   #data[:allDay] = event_params[:allDay]

   data = Event.new

   data[:name]  = params[:event][:name]
   data[:start] = Time.at(params[:event][:start].to_i / 1000)
   data[:end] = Time.at(params[:event][:end].to_i / 1000)

   p "-----------"
   p params[:event][:name]

   @event = data
   #@event = Event.new(event_params)

   respond_to do |format|
     if @event.save
       format.html { redirect_to @event, notice: 'Event was successfully created.' }
       format.json { render :show, status: :created, location: @event and return}
     else
       format.html { render :new }
       format.json { render json: @event.errors, status: :unprocessable_entity and return }
     end
   end
 end

 # PATCH/PUT /events/1
 # PATCH/PUT /events/1.json
 def update
   respond_to do |format|
     if @event.update(event_params)
       format.html { redirect_to @event, notice: 'Event was successfully updated.' }
       format.json { render :show, status: :ok, location: @event }
     else
       format.html { render :edit }
       format.json { render json: @event.errors, status: :unprocessable_entity }
     end
   end
 end

 # DELETE /events/1
 # DELETE /events/1.json
 def destroy
   @event.destroy
   respond_to do |format|
     format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
     format.json { head :no_content }
   end
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
