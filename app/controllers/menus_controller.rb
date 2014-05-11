class MenusController < ApplicationController

  # Find the tenant
  around_filter :scope_current_tenant

  before_action :set_menu, only: [:show, :edit, :update, :destroy, :add_item_to_menu]

  # GET /menus
  # GET /menus.json
  def index
    @menu = Menu.first
    @menus = Menu.all
    if @menu.present?
      redirect_to action: 'show', id: @menu
    else
      @menu = Menu.new
    end
  end

  # GET /menus/1
  # GET /menus/1.json
  def show
    @menus = Menu.all
  end

  # GET /menus/new
  def new
    @menu = Menu.new
    respond_to do |format|
      format.html { render action: 'new' }
      format.js { render action: 'new', layout: false }
    end
  end

  # GET /menus/1/edit
  def edit
    respond_to do |format|
      format.html { render action: 'edit' }
      format.js { render action: 'edit', layout: false }
    end
  end

  # POST /menus
  # POST /menus.json
  def create
    @menu = Menu.new(params[:menu])

    respond_to do |format|
      if @menu.save
        format.html { redirect_to menus_url, notice: 'Menu was successfully created.' }
        format.json { render action: 'index', status: :created, location: @menu }
      else
        format.html { render action: 'new' }
        format.json { render json: @menu.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /menus/1
  # PATCH/PUT /menus/1.json
  def update
    respond_to do |format|
      if @menu.update(params[:menu])
        format.html { redirect_to menus_url, notice: 'Menu was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'index' }
        format.json { render json: @menu.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /menus/1
  # DELETE /menus/1.json
  def destroy
    @menu.destroy
    respond_to do |format|
      format.html { redirect_to menus_url }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_menu
      @menu = Menu.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    #def menu_params
    #  params.require(:menu).permit(:name)
    #end
end
