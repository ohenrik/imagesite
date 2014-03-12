require "spec_helper"

describe PublicThemesController do
  describe "routing" do

    it "routes to #index" do
      get("/public_themes").should route_to("public_themes#index")
    end

    it "routes to #new" do
      get("/public_themes/new").should route_to("public_themes#new")
    end

    it "routes to #show" do
      get("/public_themes/1").should route_to("public_themes#show", :id => "1")
    end

    it "routes to #edit" do
      get("/public_themes/1/edit").should route_to("public_themes#edit", :id => "1")
    end

    it "routes to #create" do
      post("/public_themes").should route_to("public_themes#create")
    end

    it "routes to #update" do
      put("/public_themes/1").should route_to("public_themes#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/public_themes/1").should route_to("public_themes#destroy", :id => "1")
    end

  end
end
