class PageItemsController < ApplicationController

  # Find the tenant
  around_filter :scope_current_tenant

  before_action :set_page_item, only: [:show, :edit, :update, :destroy, :settings]


  # GET /page_items
  # GET /page_items.json
  def index
    @page_items = PageItem.all
  end

  # GET /page_items/1
  # GET /page_items/1.json
  def show
  end

  # GET /page_items/new
  def new
    @page_item = PageItem.new
  end

  # GET /page_items/1/edit
  def edit
  end

  # POST /page_items
  # POST /page_items.json
  def create
    @page_item = PageItem.new(params[:page_item])

    respond_to do |format|
      if @page_item.save
        format.html { redirect_to @page_item, notice: 'Page item was successfully created.' }
        format.json { render action: 'show', status: :created, location: @page_item }
      else
        format.html { render action: 'new' }
        format.json { render json: @page_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /page_items/1
  # PATCH/PUT /page_items/1.json
  def update
    respond_to do |format|
      if @page_item.update(params[:page_item])
        format.html { redirect_to edit_page_path(@page_item.page), notice: 'Page item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { redirect_to edit_page_path(@page_item.page) }
        format.json { render json: @page_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /page_items/1
  # DELETE /page_items/1.json
  def destroy
    @page_id = @page_item.page_id
    @page_item.destroy
    respond_to do |format|
      format.html { redirect_to edit_page_path(@page_id) }
      format.json { head :no_content }
      format.js { render js: "$('#page_item_#{@page_item.id}').remove();" }
    end
  end

  def settings
    
  end

  def sort 
    @order = params[:order]
    @order = JSON.parse(@order)

    # Updating position. This Code needs optimazation!
    update_position(@order)

    #sleep 1.5
    render js: "setTimeout(function() { $('.save-page-items').button('reset') }, 500);" 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page_item
      @page_item = PageItem.find(params[:id])
    end

    
    def update_position(object, parent = nil)
      object.each_with_index do |item, index|
        #@page_item = PageItem.find(item["id"])
        #@page_item.parent_id = parent
        PageItem.where({id: item["id"]}).update_all({:position => (index + 1), :ancestry => parent.to_s})
        update_position(item["children"], item["id"]) if !item["children"].nil? 
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    #def page_item_params
    #  params.require(:page_item).permit(:position, :page_id, :pagable_id, :pagable_type)
    #end
end
