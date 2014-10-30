class SharedController < ApplicationController

  # Find the tenant
  around_filter :scope_current_tenant

  def editor_link_modal
    @editor = params[:editor]
    @text = params[:text]

    @items = Page.all + Production.all + Person.all
    #@items.merge(Production.pluck(:id))
    #@items.merge(Person.pluck(:id))

      respond_to do |format|
        format.js { render 'editor_link_modal' }
      end
  end

end