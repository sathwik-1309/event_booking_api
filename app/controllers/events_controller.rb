class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_event_organizer
  before_action :set_event, only: [:show, :update, :destroy]
  before_action :authorize_event_owner, only: [:update, :destroy]

  def create
    ev_params = event_params
    ev_params[:event_organizer_id] = @current_user.id
    event = Event.create!(ev_params)
    
    if event.save
      render json: event, status: :created
    else
      render json: { error: event.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def index
    events = Event.all
    render json: events
  end

  def show
    render json: @event
  end

  def update
    if @event.update!(event_params)
      EventNotificationJob.perform_async(@event.id)
      render json: @event
    else
      render json: { error: @event.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy
    render json: { message: 'Event deleted' }
  end

  private

  def event_params
    params.require(:event).permit(:name, :description, :date, :venue)
  end

  def authorize_event_organizer
    unless @current_user.is_a?(EventOrganizer)
      render json: { error: 'Only event organizers can perform this action' }, status: :forbidden
    end
  end

  def authorize_event_owner
    unless @event.event_organizer_id == @current_user.id
      render json: { error: 'You can only modify your own events' }, status: :forbidden
    end
  end

  def set_event
    @event = Event.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Event not found' }, status: :not_found
  end
end