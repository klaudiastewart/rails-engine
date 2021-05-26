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
    @merchant2 = Merchant.create(name: 'ab', id: 2)
    @merchant3 = Merchant.create(name: 'abc', id: 3)
    @merchant4 = Merchant.create(name: 'abcd', id: 4)
    @merchant5 = Merchant.create(name: 'abcdE', id: 5)
    @merchant6 = Merchant.create(name: 'EFgh', id: 6)
    @merchant7 = Merchant.create(name: 'IjkL', id: 7)
    @merchant8 = Merchant.create(name: 'Jka', id: 8)
    @merchant9 = Merchant.create(name: 'iJK', id: 9)
    @merchant10 = Merchant.create(name: 'lmnopa', id: 10)
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
    it 'gets one merchant by name' do
      get '/api/v1/merchants/find?name=ijk', headers: valid_headers, as: :json
      expect(response).to be_successful
      expect(response).to have_http_status(200)
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:data][:id].to_i).to eq(@merchant7.id)
      expect(body[:data][:attributes][:name]).to eq(@merchant7.name)
    end

    it 'sends a 404 if the merchant fragment is not found' do
      get '/api/v1/merchants/find?name=gggg', headers: valid_headers, as: :json
      expect(response).to have_http_status(404)
      expect(response.body).to eq("{\"data\":{},\"error\":\"This merchant does not exist\",\"status\":404}")
    end
  end
end
