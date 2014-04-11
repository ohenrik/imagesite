require "spec_helper"

describe CodeFilesController do
  describe "routing" do

    it "routes to #index" do
      get("/code_files").should route_to("code_files#index")
    end

    it "routes to #new" do
      get("/code_files/new").should route_to("code_files#new")
    end

    it "routes to #show" do
      get("/code_files/1").should route_to("code_files#show", :id => "1")
    end

    it "routes to #edit" do
      get("/code_files/1/edit").should route_to("code_files#edit", :id => "1")
    end

    it "routes to #create" do
      post("/code_files").should route_to("code_files#create")
    end

    it "routes to #update" do
      put("/code_files/1").should route_to("code_files#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/code_files/1").should route_to("code_files#destroy", :id => "1")
    end

  end
end
