require "spec_helper"

describe PageItemsController do
  describe "routing" do

    it "routes to #index" do
      get("/page_items").should route_to("page_items#index")
    end

    it "routes to #new" do
      get("/page_items/new").should route_to("page_items#new")
    end

    it "routes to #show" do
      get("/page_items/1").should route_to("page_items#show", :id => "1")
    end

    it "routes to #edit" do
      get("/page_items/1/edit").should route_to("page_items#edit", :id => "1")
    end

    it "routes to #create" do
      post("/page_items").should route_to("page_items#create")
    end

    it "routes to #update" do
      put("/page_items/1").should route_to("page_items#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/page_items/1").should route_to("page_items#destroy", :id => "1")
    end

  end
end
