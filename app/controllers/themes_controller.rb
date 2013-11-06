require 'zip'
class ThemesController < ApplicationController

  # Scope current tenant
  around_filter :scope_current_tenant

  before_action :set_theme, only: [:show, :edit, :update, :destroy, :select_theme]

  # After uploaded zip file extract the content of the file
  after_action :extract_zip, only: [:create]

  # After uploaded a new zip file delete old exctract and extract the content of the new file.
  after_action :extract_new_zip, only: [:edit]

  # After deletion of the zip file, delete the theme as well.
  after_action :delete_extract, only: [:destroy]


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
    @theme.user.save
    redirect_to themes_path, notice: "Theme activated!"
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
        format.html { redirect_to themes_path, notice: 'Theme was successfully created.' }
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

    # Extract the zip file
    def extract_zip
      file_path = File.join(Rails.public_path, @theme.zip_url)
      Zip::File.open(file_path) do |zip_file|
        zip_file.each do |file|
          f_path = File.join(File.dirname(file_path), "theme_files", file.name)
          FileUtils.mkdir_p(File.dirname(f_path))
          zip_file.extract(file, f_path){ true }
        end
      end
    end

    # Dele old theme files and extract the new zip file
    def extract_new_zip
      delete_extract
      extract_zip
    end

    # Delete old theme files
    def delete_extract
      file_path = File.join(Rails.public_path, @theme.zip_url)
      FileUtils.rm_rf(File.join(File.dirname(file_path), "theme_files"))
    end


    # permissions file has taken over this part
    # Never trust parameters from the scary internet, only allow the white list through.
    #def theme_params
    #  params.require(:theme).permit(:name, :zip)
    #end
end
