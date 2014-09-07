class PeopleController < ApplicationController

  # Find the tenant
  around_filter :scope_current_tenant

  before_action :set_person, only: [:show, :edit, :update, :destroy, :add_to_page, :add_to_menu]

  # GET /people
  # GET /people.json
  def index
    @people = Person.all
  end

  # GET /people/1
  # GET /people/1.json
  def show
    render layout: false
  end

  # GET /people/new
  def new
    @person = Person.new
  end

  # GET /people/1/edit
  def edit
  end

  # POST /people
  # POST /people.json
  def create
    @person = Person.new(params[:person])

    respond_to do |format|
      if @person.save
        format.html { redirect_to people_path, notice: 'Person was successfully created.' }
        format.json { render action: 'show', status: :created, location: @person }
      else
        format.html { render action: 'new' }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /people/1
  # PATCH/PUT /people/1.json
  def update
    respond_to do |format|
      if @person.update(params[:person])
        format.html { redirect_to edit_person_path(@person), notice: 'Person was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1
  # DELETE /people/1.json
  def destroy
    @person.destroy
    respond_to do |format|
      format.html { redirect_to people_url }
      format.json { head :no_content }
    end
  end

  def gallery_modal
    @people = Person.all.order(first_name: :asc)

    # Passing page details right through 
    @page_id = params[:page_id]
    @page_item_id = params[:page_item_id]


    respond_to do |format|
      format.js {
        render 'page_items/gallery_modal', layout: false
      }
    end
  end


  def add_to_menu
    @menu_item = @person.menu_items.create(name: @person.name, menu_id: params[:menu_id])
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
    def set_person
      @person = Person.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def person_params
      params.require(:person).permit(:first_name, :last_name, :title, :description, :email, :phone, :mobile_phone, :photo_id)
    end
end
