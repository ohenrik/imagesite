class MenuItemsController < ApplicationController

# Find the tenant
  around_filter :scope_current_tenant

  before_action :set_menu_item, only: [:show, :edit, :update, :destroy]

  # GET /menu_items
  # GET /menu_items.json
  def index
    @menu_items = MenuItem.all
  end

  # GET /menu_items/1
  # GET /menu_items/1.json
  def show
  end

  # GET /menu_items/new
  def new
    @menu_item = MenuItem.new(:menu_id => params[:menu_id], :url => "http://")

    respond_to do |format|
      format.html { render action: 'new' }
      format.js { render action: 'new', layout: false }
    end
  end

  # GET /menu_items/1/edit
  def edit
    respond_to do |format|
      format.html { render action: 'edit' }
      format.js { render action: 'edit', layout: false }
    end
  end

  # POST /menu_items
  # POST /menu_items.json
  def create
    @menu_item = MenuItem.new(params[:menu_item])
    
    respond_to do |format|
      if @menu_item.save
        format.html { redirect_to @menu_item, notice: 'Menu item was successfully created.' }
        format.json { render action: 'show', status: :created, location: @menu_item }
        format.js { render 'add_to_menu' }
      else
        format.html { render action: 'new' }
        format.json { render json: @menu_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /menu_items/1
  # PATCH/PUT /menu_items/1.json
  def update
    respond_to do |format|
      if @menu_item.update(params[:menu_item])
        format.html { redirect_to menus_path, notice: 'Menu item was successfully updated.' }
        format.json { head :no_content }
        format.js { render 'update' }
      else
        format.html { render action: 'edit' }
        format.json { render json: @menu_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /menu_items/1
  # DELETE /menu_items/1.json
  def destroy
    @menu_item.destroy
    respond_to do |format|
      format.html { redirect_to menus_path, notice: 'Menu item deleted.'  }
      format.js { }
    end
  end


  def sort
    @order = params[:order]
    @order = JSON.parse(@order)

    # Updating position. This Code needs optimazation!
    update_position(@order)

    #sleep 1.5
    render js: "setTimeout(function() { $('.save-menu').button('reset') }, 500);" 

  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_menu_item
      @menu_item = MenuItem.find(params[:id])
    end


    def update_position(object, parent = nil)
      object.each_with_index do |item, index|
        MenuItem.where({id: item["id"]}).update_all({:position => (index + 1), :ancestry => parent.to_s})
        update_position(item["children"], item["id"]) if !item["children"].nil? 
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    #def menu_item_params
    #  params.require(:menu_item).permit(:menu_id)
    #end
end
