class PagesController < ApplicationController

  # Find the tenant
  around_filter :scope_current_tenant
  
  before_action :set_page, only: [:show, :edit, :update, :destroy, :set_thumbnail]
  

  # GET /pages
  # GET /pages.json
  def index
    @pages = Page.all
  end

  # GET /pages/1
  # GET /pages/1.json
  def show
    render layout: "theme"
  end

  # GET /pages/new
  def new
    @page = Page.new
  end

  # GET /pages/1/edit
  def edit
  end

  def set_thumbnail
    @page.photo_id = params[:photo_id]
    @page.save
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
