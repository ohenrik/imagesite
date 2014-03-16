
class ThemesController < ApplicationController

  # Scope current tenant
  around_filter :scope_current_tenant

  before_action :set_theme, only: [:show, :edit, :update, :destroy, :select_theme]


  # GET /themes
  # GET /themes.json
  def index
    @themes = Theme.all
  end

  # GET /themes/1
  # GET /themes/1.json
  def show

  end

  def select_theme
    # Set the current theme and save it!
    #@theme.user.current_theme = @theme.id
    #@theme.user.current_theme_folder = File.join(Rails.public_path, File.dirname(@theme.zip_url), "theme_files")
    #@theme.user.save
    @theme.user.theme_id = @theme.id
    if @theme.user.save
      @theme.extract_theme
      @theme.precompile_theme_assets
      redirect_to themes_path, notice: "Theme activated!"
    else
      redirect_to themes_path, notice: "Theme not activated, something went wrong"
    end
  end

  # GET /themes/new
  def new
    @theme = Theme.new
  end

  # GET /themes/1/edit
  def edit
  end

  # POST /themes
  # POST /themes.json
  def create
    @theme = Theme.new(params[:theme])
    @theme.user_id = current_user.id
    respond_to do |format|
      if @theme.save
        # After uploaded zip file extract the content of the file
        @theme.extract_preview

        format.html { redirect_to themes_url, notice: 'Theme was successfully created.' }
        format.json { render action: 'index', status: :created, location: @theme }
      else
        format.html { render action: 'new' }
        format.json { render json: @theme.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /themes/1
  # PATCH/PUT /themes/1.json
  def update
    respond_to do |format|
      if @theme.update(params[:theme])
        # After uploaded a new zip file delete old exctract and extract the content of the new file.
        @theme.extract_new_preview

        format.html { redirect_to themes_url, notice: 'Theme was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @theme.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /themes/1
  # DELETE /themes/1.json
  def destroy
    @theme.destroy
    # After deletion of the zip file, delete the theme as well.
    @theme.delete_extract

    respond_to do |format|
      format.html { redirect_to themes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_theme
      @theme = Theme.find(params[:id])
    end


    # permissions file has taken over this part
    # Never trust parameters from the scary internet, only allow the white list through.
    #def theme_params
    #  params.require(:theme).permit(:name, :zip)
    #end
end
