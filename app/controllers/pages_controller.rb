class PagesController < ApplicationController

  # Find the tenant
  around_filter :scope_current_tenant
  
  before_action :set_page, only: [:show, :edit, :update, :destroy, :set_thumbnail, :add_to_menu, :set_home, :add_to_page, :add_gallery]
  

  # GET /pages
  # GET /pages.json
  def index
    @pages = Page.all
  end

  def gallery_modal
    @pages = Page.all.order(updated_at: :desc)

    # Passing page details right through 
    @page_id = params[:page_id]
    @page_item_id = params[:page_item_id]


    respond_to do |format|
      format.js {
        render 'page_items/gallery_modal', layout: false
      }
    end
  end

  # GET /pages/1
  # GET /pages/1.json
  def show
    render layout: "theme"
  end

  # GET /pages/new
  def new
    @page = Page.create(status: "draft", name: "Temporary name")
  end

  # GET /pages/1/edit
  def edit
  end

  def set_thumbnail
    @page.photo_id = params[:photo_id]
    @page.save
    render js: "setTimeout(function () {$('#page-set-thumbnail').button('reset')}, 500);"
  end

  # POST /pages
  # POST /pages.json
  def create
    @page = Page.new(params[:page])
    @page.status ||= "draft"

    respond_to do |format|
      if @page.save
        format.html { redirect_to pages_path, notice: 'Page was successfully created.' }
        format.json { render action: 'index', status: :created, location: @page }
      else
        format.html { render action: 'new' }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pages/1
  # PATCH/PUT /pages/1.json
  def update
    respond_to do |format|
      if @page.update(params[:page])
        format.html { redirect_to pages_path, notice: 'Page was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @page.destroy
    respond_to do |format|
      format.html { redirect_to pages_url }
      format.json { head :no_content }
    end
  end

  def add_to_menu
    @menu_item = @page.menu_items.create(name: @page.name, menu_id: params[:menu_id])
    respond_to do |format|
      if @menu_item
        format.html { redirect_to menus_path, notice: 'Menu Item successfully added' }
        format.js { render template: 'menu_items/add_to_menu.js.erb' }
      else
        format.html { redirect_to menus_path, notice: 'An error occured, item no added to menu.' }
        format.json { render json: @menu.errors, status: :unprocessable_entity }
      end
    end
  end

  def add_to_page
    @page_item = @page.page_items.create(page_id: params[:page_id], position: params[:position], ancestry: params[:page_item_id])
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


  def add_gallery
    @page_item = PageItem.create(page_id: @page.id, position: params[:position], gallery: 1)
    respond_to do |format|
      if @page_item
        format.html { redirect_to edit_page_path(@page), notice: 'Item successfully added' }
        format.js { render 'page_items/page_item_added', layout: false } #render locals: { page_item: item } }
      else
        format.html { redirect_to edit_page_path(@page), notice: 'An error occured, item no added to menu.' }
        format.json { render json: @menu.errors, status: :unprocessable_entity }
      end
    end
  end


  def set_home
    @user = current_user
    @user.home = @page
    if @user.save
      redirect_to pages_path, notice: "Home screen set to #{@page.name}"
    else
      redirect_to pages_path, alert: "An error occured. Home not set."
    end
  end

#render :locals => { menu_item_id: => 1 }
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page
      @page = Page.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    #def page_params
    #  params.require(:page).permit(:title, :content, :excerpt, :status)
    #end
end
