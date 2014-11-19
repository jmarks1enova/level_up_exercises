class EventAssetsController < ApplicationController
  before_action :set_event_asset, only: [:show, :edit, :update, :destroy]

  # GET /event_assets
  # GET /event_assets.json
  def index
    @event_assets = EventAsset.all
  end

  # GET /event_assets/1
  # GET /event_assets/1.json
  def show
  end

  # GET /event_assets/new
  def new
    @event_asset = EventAsset.new
  end

  # GET /event_assets/1/edit
  def edit
  end

  # POST /event_assets
  # POST /event_assets.json
  def create
    @event_asset = EventAsset.new(event_asset_params)

    respond_to do |format|
      if @event_asset.save
        format.html { redirect_to @event_asset, notice: 'Event asset was successfully created.' }
        format.json { render :show, status: :created, location: @event_asset }
      else
        format.html { render :new }
        format.json { render json: @event_asset.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /event_assets/1
  # PATCH/PUT /event_assets/1.json
  def update
    respond_to do |format|
      if @event_asset.update(event_asset_params)
        format.html { redirect_to @event_asset, notice: 'Event asset was successfully updated.' }
        format.json { render :show, status: :ok, location: @event_asset }
      else
        format.html { render :edit }
        format.json { render json: @event_asset.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /event_assets/1
  # DELETE /event_assets/1.json
  def destroy
    @event_asset.destroy
    respond_to do |format|
      format.html { redirect_to event_assets_url, notice: 'Event asset was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event_asset
      @event_asset = EventAsset.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_asset_params
      params.require(:event_asset).permit(:calendar_event_id, :caption, :mime_type, :data)
    end
end
