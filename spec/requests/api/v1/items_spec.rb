require 'rails_helper'

RSpec.describe 'ItemsController', type: :request do
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
    @item4 = @merchant1.items.create(name: Faker::Vehicle.make, description: Faker::Lorem.sentence , unit_price: 3)
    @item5 = @merchant1.items.create(name: Faker::Vehicle.make, description: Faker::Lorem.sentence , unit_price: 3)
    @item6 = @merchant1.items.create(name: Faker::Vehicle.make, description: Faker::Lorem.sentence , unit_price: 3)
    @item7 = @merchant1.items.create(name: Faker::Vehicle.make, description: Faker::Lorem.sentence , unit_price: 3)
    @item8 = @merchant1.items.create(name: Faker::Vehicle.make, description: Faker::Lorem.sentence , unit_price: 3)
    @item9 = @merchant1.items.create(name: Faker::Vehicle.make, description: Faker::Lorem.sentence , unit_price: 3)
    @item10 = @merchant1.items.create(name: Faker::Vehicle.make, description: Faker::Lorem.sentence , unit_price: 3)
    @item11 = @merchant1.items.create(name: Faker::Vehicle.make, description: Faker::Lorem.sentence , unit_price: 3)
    @item12 = @merchant1.items.create(name: Faker::Vehicle.make, description: Faker::Lorem.sentence , unit_price: 3)
    @item13 = @merchant1.items.create(name: Faker::Vehicle.make, description: Faker::Lorem.sentence , unit_price: 3)
    @item14 = @merchant1.items.create(name: Faker::Vehicle.make, description: Faker::Lorem.sentence , unit_price: 3)
    @item15 = @merchant1.items.create(name: Faker::Vehicle.make, description: Faker::Lorem.sentence , unit_price: 3)
    @item16 = @merchant1.items.create(name: Faker::Vehicle.make, description: Faker::Lorem.sentence , unit_price: 3)
    @item17 = @merchant1.items.create(name: Faker::Vehicle.make, description: Faker::Lorem.sentence , unit_price: 3)
    @item18 = @merchant1.items.create(name: Faker::Vehicle.make, description: Faker::Lorem.sentence , unit_price: 3)
    @item19 = @merchant1.items.create(name: Faker::Vehicle.make, description: Faker::Lorem.sentence , unit_price: 3)
    @item20 = @merchant1.items.create(name: Faker::Vehicle.make, description: Faker::Lorem.sentence , unit_price: 3)
    @item21 = @merchant1.items.create(name: Faker::Vehicle.make, description: Faker::Lorem.sentence , unit_price: 3)
    @item22 = @merchant1.items.create(name: Faker::Vehicle.make, description: Faker::Lorem.sentence , unit_price: 3)
    @item23 = @merchant1.items.create(name: Faker::Vehicle.make, description: Faker::Lorem.sentence , unit_price: 3)
    @item24 = @merchant1.items.create(name: Faker::Vehicle.make, description: Faker::Lorem.sentence , unit_price: 3)
    @item25 = @merchant1.items.create(name: Faker::Vehicle.make, description: Faker::Lorem.sentence , unit_price: 3)
    @item26 = @merchant1.items.create(name: Faker::Vehicle.make, description: Faker::Lorem.sentence , unit_price: 3)
    @item27 = @merchant1.items.create(name: Faker::Vehicle.make, description: Faker::Lorem.sentence , unit_price: 3)
    @item28 = @merchant1.items.create(name: Faker::Vehicle.make, description: Faker::Lorem.sentence , unit_price: 3)
    @item29 = @merchant1.items.create(name: Faker::Vehicle.make, description: Faker::Lorem.sentence , unit_price: 3)
    @item30 = @merchant1.items.create(name: Faker::Vehicle.make, description: Faker::Lorem.sentence , unit_price: 3)
    @item31 = @merchant1.items.create(name: Faker::Vehicle.make, description: Faker::Lorem.sentence , unit_price: 3)
    @item32 = @merchant1.items.create(name: Faker::Vehicle.make, description: Faker::Lorem.sentence , unit_price: 3)
    @item33 = @merchant1.items.create(name: Faker::Vehicle.make, description: Faker::Lorem.sentence , unit_price: 3)
    @item34 = @merchant1.items.create(name: Faker::Vehicle.make, description: Faker::Lorem.sentence , unit_price: 3)
    @item35 = @merchant1.items.create(name: Faker::Vehicle.make, description: Faker::Lorem.sentence , unit_price: 3)
    @item36 = @merchant1.items.create(name: Faker::Vehicle.make, description: Faker::Lorem.sentence , unit_price: 3)
    @item37 = @merchant1.items.create(name: Faker::Vehicle.make, description: Faker::Lorem.sentence , unit_price: 3)
    @item38 = @merchant1.items.create(name: Faker::Vehicle.make, description: Faker::Lorem.sentence , unit_price: 3)
    @item39 = @merchant1.items.create(name: Faker::Vehicle.make, description: Faker::Lorem.sentence , unit_price: 3)
    @item40 = @merchant1.items.create(name: Faker::Vehicle.make, description: Faker::Lorem.sentence , unit_price: 3)
    @item41 = @merchant1.items.create(name: Faker::Vehicle.make, description: Faker::Lorem.sentence , unit_price: 3)
    @item42 = @merchant1.items.create(name: Faker::Vehicle.make, description: Faker::Lorem.sentence , unit_price: 3)
    @item43 = @merchant1.items.create(name: Faker::Vehicle.make, description: Faker::Lorem.sentence , unit_price: 3)
    @item44 = @merchant1.items.create(name: Faker::Vehicle.make, description: Faker::Lorem.sentence , unit_price: 3)
    @item45 = @merchant1.items.create(name: Faker::Vehicle.make, description: Faker::Lorem.sentence , unit_price: 3)
    @item46 = @merchant1.items.create(name: Faker::Vehicle.make, description: Faker::Lorem.sentence , unit_price: 3)
    @item47 = @merchant1.items.create(name: Faker::Vehicle.make, description: Faker::Lorem.sentence , unit_price: 3)
    @item48 = @merchant1.items.create(name: Faker::Vehicle.make, description: Faker::Lorem.sentence , unit_price: 3)
    @item49 = @merchant1.items.create(name: Faker::Vehicle.make, description: Faker::Lorem.sentence , unit_price: 3)
    @item50 = @merchant1.items.create(name: Faker::Vehicle.make, description: Faker::Lorem.sentence , unit_price: 3)
  end

  describe 'GET all items' do
    it 'gets a successful response' do
      get "/api/v1/items", headers: valid_headers, as: :json
      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:data].size).to eq(3)
      expect(body[:data].first.class).to eq(Hash)
    end

    it 'renders only 20 items' do
      get api_v1_items_url, headers: valid_headers, as: :json
      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:data].size).to eq(3)
      expect(body[:data]).to be_an(Array)
    end

    it 'fetches first page of 50 items' do
      items = Item.all
      get '/api/v1/items?per_page=50', headers: valid_headers, as: :json
      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:data].size).to eq(50)
      expect(body[:data].first[:id].to_i).to eq(items.first.id)
      expect(body[:data].last[:id].to_i).to eq(items.last.id)
    end

    it 'fetches the first 20 items on page 1' do
      get api_v1_items_url, headers: valid_headers, as: :json
      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:data][0][:attributes][:name]).to eq(@item1.name)
      expect(body[:data][19][:attributes][:name]).to eq(@item20.name)
    end

    it 'fetches the second 20 items on page 2' do
      get "/api/v1/items?page=2&per_page=20", headers: valid_headers, as: :json
      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:data][0][:attributes][:name]).to eq(@item21.name)
      expect(body[:data][19][:attributes][:name]).to eq(@item40.name)
    end

    it 'fetches page 1 if page 0 or lower' do
      get "/api/v1/items?page=0&per_page=20", headers: valid_headers, as: :json
      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:data][0][:attributes][:name]).to eq(@item1.name)
      expect(body[:data][19][:attributes][:name]).to eq(@item20.name)
    end
  end

  describe 'GET show method/single item' do
    it '' do
    end
  end 
end
