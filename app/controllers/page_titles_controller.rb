class PageTitlesController < ApplicationController

  # Find the tenant
  around_filter :scope_current_tenant
  
  before_action :set_page_title, only: [:show, :edit, :update, :destroy, :cancel_update]

  # GET /page_titles
  # GET /page_titles.json
  def index
    @page_titles = PageTitle.all
  end

  # GET /page_titles/1
  # GET /page_titles/1.json
  def show
  end

  # GET /page_titles/new
  def new
    @page_title = PageTitle.new
  end

  # GET /page_titles/1/edit
  def edit
    @page_item = params[:page_item_id]
    @page = params[:page_id] 
    respond_to do |format|
      format.js { render :action => 'edit', :page_item => @page_item}
    end
  end

  # POST /page_titles
  # POST /page_titles.json
  def create
    @page_title = PageTitle.new(params[:page_title])

    respond_to do |format|
      if @page_title.save
        format.html { redirect_to @page_title, notice: 'Page title was successfully created.' }
        format.json { render action: 'show', status: :created, location: @page_title }
      else
        format.html { render action: 'new' }
        format.json { render json: @page_title.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /page_titles/1
  # PATCH/PUT /page_titles/1.json
  def update
    @page_item = params[:page_item]
    respond_to do |format|
      if @page_title.update(params[:page_title])
        format.html { redirect_to @page_title, notice: 'Page title was successfully updated.' }
        format.json { head :no_content }
        format.js   { render :action => 'page_title_update', :page_item => @page_item }
      else
        format.html { render action: 'edit' }
        format.json { render json: @page_title.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /page_titles/1
  # DELETE /page_titles/1.json
  def destroy
    @page_item = params[:page_item_id]
    @page_title.destroy
    respond_to do |format|
      format.html { redirect_to page_titles_url }
      format.json { head :no_content }
      format.js { render js: "$('#page_item_#{@page_item}').remove();" }
    end
  end

  def cancel_update
    @page_item = params[:page_item]
    respond_to do |format|
      format.js { render :action => 'page_title_update', :page_item => @page_item }
    end 
  end




  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page_title
      @page_title = PageTitle.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    #def page_title_params
    #  params.require(:page_title).permit(:title)
    #end
end
