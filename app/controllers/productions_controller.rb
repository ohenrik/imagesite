class ProductionsController < ApplicationController

  # Find the tenant
  around_filter :scope_current_tenant
  before_action :set_production, only: [:show, :edit, :update, :destroy]

  # GET /productions
  # GET /productions.json
  def index
    @productions = Production.all
    @events = Event.where(production_id: nil)
  end

  # GET /productions/1
  # GET /productions/1.json
  def show
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
        format.html { redirect_to @production, notice: 'Production was successfully created.' }
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_production
      @production = Production.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def production_params
      params.require(:production).permit(:name, :description, :photo_id)
    end
end
