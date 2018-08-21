class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :edit, :update, :destroy]

  # GET /listings
  # GET /listings.json
  def index

    if params[:searchwords] || params[:searchmin] || params[:searchmax] || params[:location_near] || params[:date_start] || params[:date_end]
      
      @listings = Listing.includes(:user).where(nil).page(params[:page])
      @listings = @listings.free_on(params[:date_start][0],params[:date_end][0]).page(params[:page]) if params[:date_start] != [""] || params[:date_end] != [""]
      @listings = @listings.search(params[:searchwords]).page(params[:page]) if params[:searchwords] != ""
      @listings = @listings.price_range(params[:searchmin].to_i,params[:searchmax].to_i).page(params[:page]) if  params[:searchmin] != "" && params[:searchmax] != ""

    respond_to do |format|
      format.html {render :index}
      format.js
    end 

    else
    @listings = Listing.includes(reservations: :user).all.page(params[:page])
    end
  
  end

   def lost 
    "You are on the wrong page"
   end  

  # GET /listings/1
  # GET /listings/1.json
  def show
    @reservation = Reservation.new
  end

  # GET /listings/new
  def new
    @listing = Listing.new
  end

  # GET /listings/1/edit
  def edit
  end

  # POST /listings
  # POST /listings.json
  def create
    @listing = Listing.new(listing_params)

    respond_to do |format|
      if @listing.save
        format.html { redirect_to @listing, notice: 'Listing was successfully created.' }
        format.json { render :show, status: :created, location: @listing }
        current_user.role = "host"
        current_user.save
      else
        format.html { render :new }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /listings/1
  # PATCH/PUT /listings/1.json
  def update
    respond_to do |format|
      if @listing.update(listing_params)
        format.html { redirect_to @listing, notice: 'Listing was successfully updated.' }
        format.json { render :show, status: :ok, location: @listing }
      else
        format.html { render :edit }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listings/1
  # DELETE /listings/1.json
  def destroy
    @listing.destroy
    respond_to do |format|
      format.html { redirect_to listings_url, notice: 'Listing was successfully removed.' }
      format.json { head :no_content }
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listing
      @listing = Listing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def listing_params
      params.require(:listing).permit(:user_id, :home_type, :room_type, :max_guest, :room, :bathroom, :price, :listing_name, :summary, :street, :city, :state, :country, :latitude, :longitude, {images: []})
    end
end
