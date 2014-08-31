class ProductionsController < ApplicationController

  

  # Find the tenant
  around_filter :scope_current_tenant
  before_action :set_production, only: [:show, :edit, :update, :destroy, :add_to_page, :add_to_menu]

  # GET /productions
  # GET /productions.json
  def index
    @productions = Production.all
  end

  # GET /productions/1
  # GET /productions/1.json
  def show
    render action: 'show', layout: false
  end

  # GET /productions/new
  def new
    @production = Production.new
    @production.events.build do |event|
      event.offers.build
    end
  end

  # GET /productions/1/edit
  def edit
    if @production.events.blank?
      event = @production.events.build
      event.offers.build
    end
  end

  # POST /productions
  # POST /productions.json
  def create
    @production = Production.new(params[:production])

    respond_to do |format|
      if @production.save
        format.html { render action: 'edit', status: :created, location: @production , notice: 'Production was successfully created.' }
        format.json { render action: 'edit', status: :created, location: @production }
      else
        format.html { render action: 'new' }
        format.json { render json: @production.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /productions/1
  # PATCH/PUT /productions/1.json
  def update
    respond_to do |format|
      if @production.update(params[:production])
        format.html { redirect_to action: 'edit', notice: 'Production was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @production.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /productions/1
  # DELETE /productions/1.json
  def destroy
    @production.destroy
    respond_to do |format|
      format.html { redirect_to productions_url }
      format.json { head :no_content }
    end
  end

  def gallery_modal
    @productions = Production.all.order(created_at: :desc)

    # Passing page details right through 
    @page_id = params[:page_id]
    @page_item_id = params[:page_item_id]


    respond_to do |format|
      format.js {
        render 'page_items/gallery_modal', layout: false
      }
    end
  end

  def add_to_page
    @page_item = @production.sub_items.create(page_id: params[:page_id], ancestry: params[:page_item_id])
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

  def add_to_menu
    @menu_item = @production.menu_items.create(name: @production.name, menu_id: params[:menu_id])
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_production
      @production = Production.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    #def production_params
    #  params.require(:production).permit(:name, :description, :photo_id)
    #end
end
