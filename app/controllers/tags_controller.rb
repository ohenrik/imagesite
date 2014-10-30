class TagsController < ApplicationController

  # Find the tenant
  around_filter :scope_current_tenant

  before_action :set_tag, only: [:edit, :update, :destroy, :add_to_menu]

  def index
    @tags = Tag.all
      respond_to do |format|
        format.js { render 'launch-tags-modal'}
      end
  end

  def destroy
    @tag.destroy
    respond_to do |format|
      format.html { redirect_to all_url }
      format.json { head :no_content }
    end
  end

  def edit
    respond_to do |format|
      format.js { render 'insert_form' }
    end
  end

  def update
      respond_to do |format|
        if @tag.update(params[:tag])
          format.html { redirect_to photos_path, notice: 'Tag was successfully updated.' }
          format.json { head :no_content }
          format.js { render 'insert_result'}
        else
          format.html { render action: 'edit' }
          format.json { render json: @tag.errors, status: :unprocessable_entity }

        end
      end
  end
  
  def add_to_menu
    @menu_item = @tag.menu_items.create(name: @tag.name, menu_id: params[:menu_id])
    respond_to do |format|
      if @menu_item
        format.html { redirect_to menus_path, notice: 'Menu Item successfully added' }
        format.js {  render template: 'menu_items/add_to_menu.js.erb' }
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
