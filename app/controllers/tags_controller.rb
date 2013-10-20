class TagsController < ApplicationController

	# Find the tenant
	around_filter :scope_current_tenant

	before_action :set_tag, only: [:edit, :destroy]

	before_filter :authorize

	def index
		@tags = Tag.all
	end

	def destroy
		@tag.destroy
		respond_to do |format|
			format.html { redirect_to tags_url }
			format.json { head :no_content }
		end
	end

	private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag
      @tag = Tag.find(params[:id])
    end


end
