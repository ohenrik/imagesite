class TextsController < ApplicationController

  # Find the tenant
  around_filter :scope_current_tenant

  before_action :set_text, only: [:show, :edit, :update, :destroy]

  # GET /texts
  # GET /texts.json
  def index
    @texts = Text.all
  end

  # GET /texts/1
  # GET /texts/1.json
  def show
  end

  # GET /texts/new
  def new
    @text = Text.new
  end

  # GET /texts/1/edit
  def edit
    @page_item = params[:page_item_id]
    @page = params[:page_id] 
    respond_to do |format|
      format.js { render :action => 'edit', :page_item => @page_item}
    end
  end

  # POST /texts
  # POST /texts.json
  def create
    @text = Text.new(params[:text])

    respond_to do |format|
      if @text.save
        format.html { redirect_to @text, notice: 'Text was successfully created.' }
        format.json { render action: 'show', status: :created, location: @text }
      else
        format.html { render action: 'new' }
        format.json { render json: @text.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /texts/1
  # PATCH/PUT /texts/1.json
  def update
    @page_item = params[:page_item]
    respond_to do |format|
      if @text.update(params[:text])
        format.html { redirect_to @text, notice: 'Text was successfully updated.' }
        format.json { head :no_content }
        format.js   { render :action => 'text_update', :page_item => @page_item }
      else
        format.html { render action: 'edit' }
        format.json { render json: @text.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /texts/1
  # DELETE /texts/1.json
  def destroy
    @text.destroy
    respond_to do |format|
      format.html { redirect_to texts_url }
      format.json { head :no_content }
    end
  end



  def add_to_page
    @text = Text.create
    @page_item = PageItem.create(page_id: params[:id], position: params[:position], pageable: @text)
    respond_to do |format|
      if @page_item
        format.html { redirect_to edit_page_path(params[:id]), notice: 'Item successfully added' }
        format.js { render 'page_items/page_item_added', layout: false } #render locals: { page_item: item } }
      else
        format.html { redirect_to edit_page_path(params[:id]), notice: 'An error occured, item no added to menu.' }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end

  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_text
      @text = Text.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    #def text_params
    #  params.require(:text).permit(:content)
    #end
end
