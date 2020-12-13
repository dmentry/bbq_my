class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]

  before_action :set_event, only: [:show]
  before_action :set_current_user_event, only: [:edit, :update, :destroy]

  # GET /events
  def index
    @events = Event.all
  end

  # GET /events/1
  def show
  end

  # GET /events/new
  def new
    @event = current_user.events.build
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  def create
    @event = current_user.events.build(event_params)

    # respond_to do |format|
      if @event.save
        redirect_to @event, notice: I18n.t('controllers.events.created')
        # format.html { redirect_to @event, notice: 'Event was successfully created.' }
        # format.json { render :show, status: :created, location: @event }
      else
        # format.html { render :new }
        render :new
        # format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    # end
  end

  # PATCH/PUT /events/1
  def update
    # respond_to do |format|
      if @event.update(event_params)
        redirect_to @event, notice: I18n.t('controllers.events.updated')
        # format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        # format.json { render :show, status: :ok, location: @event }
      else
        render :edit
        # format.html { render :edit }
        # format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    # end
  end

  # DELETE /events/1
  def destroy
    @event.destroy
    redirect_to events_url, notice: I18n.t('controllers.events.destroyed')
    # respond_to do |format|
    #   format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      # format.json { head :no_content }
    # end
  end

  private

    def set_current_user_event
      @event = current_user.events.find(params[:id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:title, :address, :datetime, :description)
    end
end
