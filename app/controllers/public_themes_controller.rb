class PublicThemesController < ApplicationController
  

  before_action :set_public_theme, only: [:show, :edit, :update, :destroy]

  # GET /public_themes
  # GET /public_themes.json
  def index
    @public_themes = PublicTheme.all
  end

  # GET /public_themes/1
  # GET /public_themes/1.json
  def show
  end

  # GET /public_themes/new
  def new
    @public_theme = PublicTheme.new
  end

  # GET /public_themes/1/edit
  def edit
  end

  # POST /public_themes
  # POST /public_themes.json
  def create
    @public_theme = PublicTheme.new(public_theme_params)

    respond_to do |format|
      if @public_theme.save
        format.html { redirect_to @public_theme, notice: 'Public theme was successfully created.' }
        format.json { render action: 'show', status: :created, location: @public_theme }
      else
        format.html { render action: 'new' }
        format.json { render json: @public_theme.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /public_themes/1
  # PATCH/PUT /public_themes/1.json
  def update
    respond_to do |format|
      if @public_theme.update(public_theme_params)
        format.html { redirect_to @public_theme, notice: 'Public theme was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @public_theme.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /public_themes/1
  # DELETE /public_themes/1.json
  def destroy
    @public_theme.destroy
    respond_to do |format|
      format.html { redirect_to public_themes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_public_theme
      @public_theme = PublicTheme.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def public_theme_params
      params.require(:public_theme).permit(:name, :zip)
    end
end
