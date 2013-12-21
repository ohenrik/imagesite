class TagsController < ApplicationController

	# Find the tenant
	around_filter :scope_current_tenant

	before_action :set_tag, only: [:edit, :destroy, :add_to_menu]

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

	
	def add_to_menu
		item = @tag.menu_items.create(name: @tag.name, menu_id: params[:menu_id])
		respond_to do |format|
			if item
				format.html { redirect_to menus_path, notice: 'Menu Item successfully added' }
				format.js { render locals: { menu_item: item } }
			else
				format.html { redirect_to menus_path, notice: 'An error occured, item no added to menu.' }
				format.json { render json: @menu.errors, status: :unprocessable_entity }
			end
		end
	end




	private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag
      @tag = Tag.find(params[:id])
    end


end
