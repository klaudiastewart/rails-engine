require 'rails_helper'

describe 'SearchController', type: :request do
  describe "GET call" do
    it 'gets all merchants' do
      get 'api/v1/merchants'

      expect(response).to be_successful
      expect(response).to have_http_status(200)
      expect(response).to render_template("index")
      @merchants = JSON.parse(response.body, symbolize_names: true)
      expect(@merchants[:data].count).to eq(20)
    end
  end
end
