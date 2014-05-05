
class ThemesController < ApplicationController

  # Scope current tenant
  around_filter :scope_current_tenant, except: [:make_public, :public_index, :public_destroy]

  before_action :set_theme, only: [:show, :edit, :update, :destroy, :public_destroy, :select_theme]


  # GET /themes
  # GET /themes.json
  def index
    @themes = Theme.all
  end

  def public_index
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
      #@theme.extract_theme
      #@theme.precompile_theme_assets
      redirect_to themes_path, notice: "Theme - #{@theme.name} - activated!"
    else
      redirect_to themes_path, notice: "Theme not activated, something went wrong"
    end
  end

  # GET /themes/new
  def new
    @theme = Theme.new
    respond_to do |format|
        format.html {  }
        format.js { render template: 'themes/edit' }
    end
  end

  # GET /themes/1/edit
  def edit
    respond_to do |format|
        format.html {  }
        format.js {  }
    end 
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
        # @theme.extract_new_preview

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
    # @theme.delete_extract

    respond_to do |format|
      format.html { redirect_to themes_url }
      format.json { head :no_content }
    end
  end

  def public_destroy
    @theme.destroy
    respond_to do |format|
      format.html { redirect_to public_themes_url }
      format.json { head :no_content }
    end
  end

  def publish_theme
    @origin = "tenant#{current_tenant.id},public"
    @destination = "public"
    transfer_theme()
  end

  def install_theme
    @origin = "public"
    @destination = "tenant#{current_tenant.id},public"
    transfer_theme()
  end

  def transfer_theme()

    # New public theme
    @public_theme = Theme.new

    # Scope correct tenant
    connection = Theme.connection
    original_search_path = connection.schema_search_path
    connection.schema_search_path = @origin

    #Find the original local theme
    @theme = Theme.find(params[:id])

    # Start Copying the Theme
    @public_theme.name = @theme.name
    @public_theme.user_id = current_tenant.id
    @public_theme.remote_thumbnail_url = @theme.thumbnail_url

    # Unscope the tenant again before saving public theme
    connection.schema_search_path = @destination

    # Save the new public theme
    if @public_theme.save
      # Then copy each Code_file / Scope in to the tenant to get the code files
      connection.schema_search_path = @origin
      @theme.code_files.each do |code_file|
        # Scope out again
        

        # Copy the code file
        connection.schema_search_path = @destination
        @public_code_file = CodeFile.new(theme_id: @public_theme.id)
        connection.schema_search_path = @origin

        @public_code_file.name =  code_file.name
        @public_code_file.display_name =  code_file.display_name
        @public_code_file.code =  code_file.code
        @public_code_file.hierarchy =  code_file.hierarchy
        @public_code_file.available_to =  code_file.available_to
        @public_code_file.available_in =  code_file.available_in
        if code_file.static_file.present?
          @public_code_file.remote_static_file_url = code_file.static_file_url
        end

        connection.schema_search_path = @destination
        @public_code_file.save
        connection.schema_search_path = original_search_path
        
      end
      redirect_to themes_url, notice: "Theme is now public."
    else
      redirect_to themes_url, alert: "Something went wrong."
    end    
  end

  def public_theme?
    params[:public_theme_id] == true
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
