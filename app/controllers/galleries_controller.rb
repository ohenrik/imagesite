class GalleriesController < ApplicationController

  # Find the tenant
  around_filter :scope_current_tenant

  before_action :set_gallery, only: [:show, :edit, :update, :destroy, :add_to_menu]

  # GET /galleries
  # GET /galleries.json
  def index
    @galleries = Gallery.all
  end

  # GET /galleries/1
  # GET /galleries/1.json
  def show
  end

  # GET /galleries/new
  def new
    @gallery = Gallery.new
  end

  # GET /galleries/1/edit
  def edit
  end

  # POST /galleries
  # POST /galleries.json
  def create
    @gallery = Gallery.new(params[:page])

    respond_to do |format|
      if @gallery.save
        format.html { redirect_to @gallery, notice: 'Gallery was successfully created.' }
        format.json { render action: 'show', status: :created, location: @gallery }
      else
        format.html { render action: 'new' }
        format.json { render json: @gallery.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /galleries/1
  # PATCH/PUT /galleries/1.json
  def update
    respond_to do |format|
      if @gallery.update(params[:page])
        format.html { redirect_to @gallery, notice: 'Gallery was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @gallery.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /galleries/1
  # DELETE /galleries/1.json
  def destroy
    @gallery.destroy
    respond_to do |format|
      format.html { redirect_to galleries_url }
      format.json { head :no_content }
    end
  end

  def add_to_menu
    item = @gallery.menu_items.create(name: @gallery.title, menu_id: params[:menu_id])
    respond_to do |format|
      if item
        format.html { redirect_to menus_path, notice: 'Menu Item successfully added' }
        format.js { render locals: { menu_item: item } }
      else
        format.html { redirect_to menus_path, notice: 'An error occured, item no added to menu.' }
        format.json { render json: @menu.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gallery
      @gallery = Gallery.find(params[:id])
    end

    ## Never trust parameters from the scary internet, only allow the white list through.
    #def gallery_params
    #  params.require(:gallery).permit(:title, :subtitle, :description, :gallery_type)
    #end
end
