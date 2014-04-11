class CodeFilesController < ApplicationController

  # Scope current tenant
  around_filter :scope_current_tenant

  before_action :set_code_file, only: [:show, :edit, :update, :destroy]

  # GET /code_files
  # GET /code_files.json
  def index
    @code_files = CodeFile.where(theme_id: params[:theme_id]).all
  end

  # GET /code_files/1
  # GET /code_files/1.json
  def show
  end

  # GET /code_files/new
  def new
    @code_file = CodeFile.new
    @theme = Theme.find(params[:theme_id])
  end

  # GET /code_files/1/edit
  def edit
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
        format.html { redirect_to edit_theme_code_file_url(id: @code_file.id, theme: @code_file.theme_id), notice: 'Code file was successfully created.' }
        format.json { render action: 'show', status: :created, location: @code_file }
      else
        format.html { render action: 'new' }
        format.json { render json: @code_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /code_files/1
  # PATCH/PUT /code_files/1.json
  def update
    respond_to do |format|
      if @code_file.update(params[:code_file])
        format.html { redirect_to edit_theme_code_file_url, notice: 'Code file was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @code_file.errors, status: :unprocessable_entity }
      end
    end
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
