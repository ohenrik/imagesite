class PhotosController < ApplicationController
  
  # Find the tenant
  around_filter :scope_current_tenant

  before_action :set_photo, only: [:show, :edit, :update, :destroy]
  

  # Check if the tenant is in his own subdomain
  

  # GET /photos
  # GET /photos.json
  def index
    if params[:tag] 
      @photos = Tag.find_by_name(params[:tag]).try(:photos)
      #@photo = Photo.tagged_with(params[:tag])
    else     
      @photos = Photo.all
    end
  end

  # GET /photos
  # GET /photos.json
  def list
    if params[:tag] 
      @photos = Tag.find_by_name(params[:tag]).try(:photos)
      #@photo = Photo.tagged_with(params[:tag])
    else     
      @photos = Photo.all
    end
  end

  # GET /photos/1
  # GET /photos/1.json
  def show
    render layout: "theme"
  end

  # GET /photos/new
  def new
    @photo = Photo.new
  end

  # GET /photos/1/edit
  def edit
  end

  # POST /photos
  # POST /photos.json
  def create
    @photo = Photo.new(params[:photo])

    respond_to do |format|
      if @photo.save
        format.html { redirect_to @photo, notice: 'Photo was successfully created.' }
        format.json { render action: 'show', status: :created, location: @photo }
      else
        format.html { render action: 'new' }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update
    respond_to do |format|
      if @photo.update(params[:photo])
        format.html { redirect_to photos_url, notice: 'Photo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to photos_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
    end

    ## Moved the Strong parametres into the permitt class
    # Never trust parameters from the scary internet, only allow the white list through.
    #def photo_params
    #  params.require(:photo).permit(:name, :image, :edit_tag_list, :description)
    #end
end
