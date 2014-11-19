class EventSourcesController < ApplicationController
  before_action :set_event_source, only: [:show, :edit, :update, :destroy]

  # GET /event_sources
  # GET /event_sources.json
  def index
    @event_sources = EventSource.all
  end

  # GET /event_sources/1
  # GET /event_sources/1.json
  def show
  end

  # GET /event_sources/new
  def new
    @event_source = EventSource.new
  end

  # GET /event_sources/1/edit
  def edit
  end

  # POST /event_sources
  # POST /event_sources.json
  def create
    @event_source = EventSource.new(event_source_params)

    respond_to do |format|
      if @event_source.save
        format.html { redirect_to @event_source, notice: 'Event source was successfully created.' }
        format.json { render :show, status: :created, location: @event_source }
      else
        format.html { render :new }
        format.json { render json: @event_source.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /event_sources/1
  # PATCH/PUT /event_sources/1.json
  def update
    respond_to do |format|
      if @event_source.update(event_source_params)
        format.html { redirect_to @event_source, notice: 'Event source was successfully updated.' }
        format.json { render :show, status: :ok, location: @event_source }
      else
        format.html { render :edit }
        format.json { render json: @event_source.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /event_sources/1
  # DELETE /event_sources/1.json
  def destroy
    @event_source.destroy
    respond_to do |format|
      format.html { redirect_to event_sources_url, notice: 'Event source was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event_source
      @event_source = EventSource.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_source_params
      params.require(:event_source).permit(:name, :url, :frequency, :last_harvest, :json_parameters)
    end
end
