require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

  describe "GET profile" do
    it "returns http success" do
      get :profile
      expect(response).to be_success
    end
  end

end
