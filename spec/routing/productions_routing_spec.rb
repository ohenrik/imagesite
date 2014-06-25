require "spec_helper"

describe ProductionsController do
  describe "routing" do

    it "routes to #index" do
      get("/productions").should route_to("productions#index")
    end

    it "routes to #new" do
      get("/productions/new").should route_to("productions#new")
    end

    it "routes to #show" do
      get("/productions/1").should route_to("productions#show", :id => "1")
    end

    it "routes to #edit" do
      get("/productions/1/edit").should route_to("productions#edit", :id => "1")
    end

    it "routes to #create" do
      post("/productions").should route_to("productions#create")
    end

    it "routes to #update" do
      put("/productions/1").should route_to("productions#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/productions/1").should route_to("productions#destroy", :id => "1")
    end

  end
end
