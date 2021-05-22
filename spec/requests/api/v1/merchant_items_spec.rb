require 'rails_helper'

RSpec.describe 'MerchantController', type: :request do
  let(:valid_headers) {
     {"CONTENT_TYPE" => "application/json"}
     {"Etag" => "f22061f294b256cf0e04fa4d150cee30"}
     {"Cache-Control" => "max-age=0, private, must-revalidate"}
     {"X-Request-id" => "aab43c90-7f82-4ec7-9101-6a22b6e341e4"}
     {"X-Runtime" => "0.095101"}
     {"Transfer-Encoding" => "chunked"}
   }
  before(:each) do
    @merchant1 = Merchant.create(name: Faker::Name.name, id: 1)
    @item1 = @merchant1.items.create(name: Faker::Vehicle.make, description: Faker::Lorem.sentence , unit_price: 1)
    @item2 = @merchant1.items.create(name: Faker::Vehicle.make, description: Faker::Lorem.sentence , unit_price: 2)
    @item3 = @merchant1.items.create(name: Faker::Vehicle.make, description: Faker::Lorem.sentence , unit_price: 3)
  end

  describe 'GET single merchants items' do
    it 'gets a successful response' do
      get "/api/v1/merchants/#{@merchant1.id}/items", headers: valid_headers, as: :json
      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:data].size).to eq(3)
      expect(body[:data].first.class).to eq(Hash)
    end

    it 'fetches all items for a merchant' do
      get "/api/v1/merchants/#{@merchant1.id}/items", headers: valid_headers, as: :json
      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:data].first[:attributes][:name]).to eq(@item1.name)
      expect(body[:data].first[:attributes][:description]).to eq(@item1.description)
      expect(body[:data].first[:attributes][:unit_price]).to eq(@item1.unit_price)
      expect(body[:data].last[:attributes][:name]).to eq(@item3.name)
      expect(body[:data].last[:attributes][:description]).to eq(@item3.description)
      expect(body[:data].last[:attributes][:unit_price]).to eq(@item3.unit_price)
    end
  end
end
