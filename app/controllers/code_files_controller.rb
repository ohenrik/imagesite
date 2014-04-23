class CodeFilesController < ApplicationController

  # Scope current tenant
  around_filter :scope_current_tenant

  before_action :set_code_file, only: [:edit, :update, :destroy]

  #caches_action :show, expire: 5.minutes

  # GET /code_files
  # GET /code_files.json
  def index
    @code_file = CodeFile.new
    @theme = Theme.find(params[:theme_id])
    @code_files = CodeFile.where(theme_id: params[:theme_id])
  end

  # GET /code_files/1
  # GET /code_files/1.json
  def show
    # Uses ! to indicate that the controller should return 404 when the requested record is not an asset or not found.
    if params[:format]
      @code_file = CodeFile.find_by!(name: "#{params[:id]}.#{params[:format]}", hierarchy: 'asset')
    else
      @code_file = CodeFile.find_by!(name: "#{params[:id]}", hierarchy: 'asset')
    end
    respond_to do |format|
      if @code_file.static_file.blank?
        format.css { render :text => @code_file.code, :content_type => "text/css" }
        format.js { render :text => @code_file.code, :content_type => "text/javascript" }
        format.any { render :text => @code_file.code }
      else
        format.css { redirect_to @code_file.static_file.url, :type => "text/css", :disposition => 'inline' }
        format.js { redirect_to @code_file.static_file.url, :type => "text/javascript", :disposition => 'inline' }
        format.any { redirect_to @code_file.static_file.url, :disposition => 'inline' }
      end
    end
  end

  # GET /code_files/new
  def new
    @code_files = CodeFile.where(theme_id: params[:theme_id]).all
    @code_file = CodeFile.new
    @theme = Theme.find(params[:theme_id])
  end

  # GET /code_files/1/edit
  def edit
    @code_files = CodeFile.where(theme_id: params[:theme_id])
    @theme = Theme.find(params[:theme_id])
  end

  # POST /code_files
  # POST /code_files.json
  def create
    @code_file = CodeFile.new(params[:code_file])
    # Set the theme id
    @code_file.theme_id = params[:theme_id]
    respond_to do |format|
      if @code_file.save
        if @code_file.static_file.blank?
          format.html { redirect_to edit_theme_code_file_url(id: @code_file.id, theme: @code_file.theme_id), notice: 'Code file was successfully created.' }
          format.json { redirect_to edit_theme_code_file_url(id: @code_file.id, theme: @code_file.theme_id), status: :created, location: @code_file }
        else
          format.html { redirect_to theme_code_files_path, notice: 'Code file was successfully created.' }
          format.json { redirect_to theme_code_files_path, status: :created, location: @code_file }
        end
      else
        format.html { redirect_to theme_code_files_path }
        format.json { render json: @code_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /code_files/1
  # PATCH/PUT /code_files/1.json
  def update
    respond_to do |format|
      if @code_file.update(params[:code_file])
        #expire_action controller: 'code_files', action: 'show', id: @code_file.id
        format.html { redirect_to edit_theme_code_file_url, notice: 'Code file was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @code_file.errors, status: :unprocessable_entity }
      end
    end
  end


  def custom_cache_path
    "#{current_tenant.subdomain}/#{@code_file.name}"
  end

  # DELETE /code_files/1
  # DELETE /code_files/1.json
  def destroy
    @code_file.destroy
    respond_to do |format|
      format.html { redirect_to theme_code_files_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_code_file
      @code_file = CodeFile.find(params[:id])
    end


    ## Never trust parameters from the scary internet, only allow the white list through.
    #def code_file_params
    #  params.require(:code_file).permit(:theme_id, :name, :code, :hierarchy)
    #end
end
