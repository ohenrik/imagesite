class PublicCodeFilesController < ApplicationController
  before_action :set_public_code_file, only: [:show, :edit, :update, :destroy]

  # GET /public_code_files
  # GET /public_code_files.json
  def index
    @public_code_files = PublicCodeFile.all
  end

  # GET /public_code_files/1
  # GET /public_code_files/1.json
  def show
  end

  # GET /public_code_files/new
  def new
    @public_code_file = PublicCodeFile.new
  end

  # GET /public_code_files/1/edit
  def edit
  end

  # POST /public_code_files
  # POST /public_code_files.json
  def create
    @public_code_file = PublicCodeFile.new(public_code_file_params)

    respond_to do |format|
      if @public_code_file.save
        format.html { redirect_to @public_code_file, notice: 'Public code file was successfully created.' }
        format.json { render action: 'show', status: :created, location: @public_code_file }
      else
        format.html { render action: 'new' }
        format.json { render json: @public_code_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /public_code_files/1
  # PATCH/PUT /public_code_files/1.json
  def update
    respond_to do |format|
      if @public_code_file.update(public_code_file_params)
        format.html { redirect_to @public_code_file, notice: 'Public code file was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @public_code_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /public_code_files/1
  # DELETE /public_code_files/1.json
  def destroy
    @public_code_file.destroy
    respond_to do |format|
      format.html { redirect_to public_code_files_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_public_code_file
      @public_code_file = PublicCodeFile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def public_code_file_params
      params.require(:public_code_file).permit(:public_theme_id, :name, :code, :hierarchy, :available_to, :available_in, :static_file, :display_name)
    end
end
