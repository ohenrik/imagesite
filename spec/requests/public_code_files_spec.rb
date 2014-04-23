require 'spec_helper'

describe "PublicCodeFiles" do
  describe "GET /public_code_files" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get public_code_files_path
      response.status.should be(200)
    end
  end
end
