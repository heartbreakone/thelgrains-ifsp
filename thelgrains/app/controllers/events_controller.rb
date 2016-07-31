##
# Controlador genérico de agendamentos para a view com FullCalendar.
class EventsController < ApplicationController
  include XhrRequestable

  before_action :set_event, only: [:show, :edit, :update, :destroy]
  clear_respond_to
  respond_to :json

  # GET /events
  # GET /events.json
  def index
    @events = Agendamento.all
    @events = @events.between(params['start'], params['end']) if (params['start'] && params['end'])
    respond_to do |format|
      format.json { render :json => @events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    render 'events/show'
  end

  # POST /events
  # POST /events.json
  def create
    @event = Agendamento.new(event_params)
    respond_to do |format|
      if @event.save
        format.json { render :show, status: :created }
      else
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.json { render :show, status: :ok }
      else
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Agendamento.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    params.require(:event).permit(:id, :title, :description, :start_time, :end_time, :all_day, :user_id, :cliente_id)
  end
end
