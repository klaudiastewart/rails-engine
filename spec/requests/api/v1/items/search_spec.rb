require 'rails_helper'

describe 'SearchController', type: :request do
  let(:valid_headers) {
     {"CONTENT_TYPE" => "application/json"}
     {"Etag" => "f22061f294b256cf0e04fa4d150cee30"}
     {"Cache-Control" => "max-age=0, private, must-revalidate"}
     {"X-Request-id" => "aab43c90-7f82-4ec7-9101-6a22b6e341e4"}
     {"X-Runtime" => "0.095101"}
     {"Transfer-Encoding" => "chunked"}
   }
  before(:each) do
    @merchant1 = Merchant.create(name: 'a', id: 1)
    @item1 = @merchant1.items.create(name: 'zaz', description: Faker::Lorem.sentence , unit_price: 1)
    @item2 = @merchant1.items.create(name: 'zza', description: Faker::Lorem.sentence , unit_price: 2)
    @item3 = @merchant1.items.create(name: 'aza', description: Faker::Lorem.sentence , unit_price: 3)
    @item4 = @merchant1.items.create(name: 'blue', description: Faker::Lorem.sentence , unit_price: 3)
    @item5 = @merchant1.items.create(name: 'lueb', description: Faker::Lorem.sentence , unit_price: 3)
    @item6 = @merchant1.items.create(name: 'blueqo', description: Faker::Lorem.sentence , unit_price: 3)
    @item7 = @merchant1.items.create(name: 'balue', description: Faker::Lorem.sentence , unit_price: 3)
    @item8 = @merchant1.items.create(name: 'oplea', description: Faker::Lorem.sentence , unit_price: 3)
    @item9 = @merchant1.items.create(name: 'arw', description: Faker::Lorem.sentence , unit_price: 3)
    @item10 = @merchant1.items.create(name: 'vablueo', description: Faker::Lorem.sentence, unit_price: 1)
  end

  describe "GET call" do
    it 'gets all items with name fragment' do
      get '/api/v1/items/find_all?name=Blu', headers: valid_headers, as: :json
      expect(response).to be_successful
      expect(response).to have_http_status(200)
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:data].count).to eq(3)
      expect(body[:data].first[:attributes][:name]).to eq(@item4.name)
      expect(body[:data].second[:attributes][:name]).to eq(@item6.name)
      expect(body[:data].last[:attributes][:name]).to eq(@item10.name)
    end

    it 'sends a 404 if the item fragment is not found' do
      get '/api/v1/items/find_all?name=ggGGGgg', headers: valid_headers, as: :json
      expect(response).to have_http_status(404)
      expect(response.body).to eq("{\"data\":[],\"error\":\"No match found\"}")
    end
  end
end
