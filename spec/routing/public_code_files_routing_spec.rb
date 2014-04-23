require "spec_helper"

describe PublicCodeFilesController do
  describe "routing" do

    it "routes to #index" do
      get("/public_code_files").should route_to("public_code_files#index")
    end

    it "routes to #new" do
      get("/public_code_files/new").should route_to("public_code_files#new")
    end

    it "routes to #show" do
      get("/public_code_files/1").should route_to("public_code_files#show", :id => "1")
    end

    it "routes to #edit" do
      get("/public_code_files/1/edit").should route_to("public_code_files#edit", :id => "1")
    end

    it "routes to #create" do
      post("/public_code_files").should route_to("public_code_files#create")
    end

    it "routes to #update" do
      put("/public_code_files/1").should route_to("public_code_files#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/public_code_files/1").should route_to("public_code_files#destroy", :id => "1")
    end

  end
end
