class PhotosController < ApplicationController
  
  # Find the tenant
  around_filter :scope_current_tenant

  before_action :set_photo, only: [:show, :edit, :update, :destroy, :add_to_page, :set_as_thumbnail]


  # Check if the tenant is in his own subdomain
  
  # GET /photos
  # GET /photos.json
  def index
    if params[:tag] 
      @tag = Tag.find_by_id(params[:tag])
      @photos = @tag.try(:photos)
      render 'index', layout: false
    else     
      redirect_to action: 'all'
    end
  end

  def photo_manager_modal
    @photos = Photo.all.order(created_at: :desc)

    # Passing page details right through 
    @page_id = params[:page_id]
    @page_item_id = params[:page_item_id]

    respond_to do |format|
      format.js {
        render 'photo_manager_modal', layout: false
      }
    end
  end

  def gallery_modal
    @photos = Photo.all.order(created_at: :desc)

    # Passing page details right through 
    @page_id = params[:page_id]
    @page_item_id = params[:page_item_id]


    respond_to do |format|
      format.js {
        render 'page_items/gallery_modal', layout: false
      }
    end
  end

  def thumbnail_modal
    @photos = Photo.all.order(created_at: :desc)

    # Passing page details right through 
    @item = params[:item]
    @item_id = params[:item_id]

    respond_to do |format|
      format.js {
        render layout: false
      }
    end
  end


  def set_as_thumbnail
    if params[:item].classify.constantize.exists?(params[:item_id])
      @item = params[:item].classify.constantize.find(params[:item_id])
      @item.photo_id = @photo.id
      @item.save
      #get the model name pluralized
      model_name = @item.class.to_s.underscore.pluralize
      #redirect to the index action of the model
      redirect_to referer, notice: "Thumbnail set"
    else
      redirect_to referer, notice: "Error: thumbnail not set. Contact support"  ## To send people dynamically to index send("#{model_name}_path"),
    end
  end

  # GET /photos
  # GET /photos.json
  def all
    @photo = Photo.new
    if params[:tag] 
      @photos = Tag.find_by_name(params[:tag]).try(:photos)
      @photos ||= Tag.find_by_id(params[:tag]).try(:photos)
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
    respond_to do |format|
      format.html { render action: 'new' }
      format.js { render 'launch-photo-modal'}
    end
  end

  # GET /photos/1/edit
  def edit
    respond_to do |format|
      format.html { render action: 'edit' }
      format.js { render 'launch-photo-modal'}
    end
  end

  # POST /photos
  # POST /photos.json
  def create
    @photo = Photo.new(params[:photo])
    @photo.user_id = current_tenant.id

    @photo.name =  @photo.image.file.filename if ( @photo.name == "" && @photo.image.file)

    respond_to do |format|
      if @photo.save
        format.html { redirect_to all_url, notice: 'Photo was successfully created.' }
        format.json { render action: 'all', status: :created, location: @photo }
        format.js {}
      else
        format.html { redirect_to all_url, alert: 'Error: Photo not uploaded please select a image file.' }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
        format.js {}
      end
    end
  end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update
    respond_to do |format|
      if @photo.update(params[:photo])
        format.html { redirect_to all_url, notice: 'Photo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { redirect_to all_url, alert: 'Error: Photo not edited please select a image file.' }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end




  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to all_url }
      format.json { head :no_content }
    end
  end



  def add_to_page
    @page_item = @photo.sub_items.create(page_id: params[:page_id], ancestry: params[:page_item_id])
    respond_to do |format|
      if @page_item
        format.html { redirect_to edit_page_path(params[:page_id]), notice: 'Item successfully added' }
        format.js { render 'page_items/page_item_added', layout: false } #render locals: { page_item: item } }
      else
        format.html { redirect_to edit_page_path(params[:page_id]), notice: 'An error occured, item no added to menu.' }
        format.json { render json: @menu.errors, status: :unprocessable_entity }
      end
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
