require "spec_helper"

describe PageTitlesController do
  describe "routing" do

    it "routes to #index" do
      get("/page_titles").should route_to("page_titles#index")
    end

    it "routes to #new" do
      get("/page_titles/new").should route_to("page_titles#new")
    end

    it "routes to #show" do
      get("/page_titles/1").should route_to("page_titles#show", :id => "1")
    end

    it "routes to #edit" do
      get("/page_titles/1/edit").should route_to("page_titles#edit", :id => "1")
    end

    it "routes to #create" do
      post("/page_titles").should route_to("page_titles#create")
    end

    it "routes to #update" do
      put("/page_titles/1").should route_to("page_titles#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/page_titles/1").should route_to("page_titles#destroy", :id => "1")
    end

  end
end
