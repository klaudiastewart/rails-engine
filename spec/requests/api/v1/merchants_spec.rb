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
     @merchant2 = Merchant.create(name: Faker::Name.name, id: 2)
     @merchant3 = Merchant.create(name: Faker::Name.name, id: 3)
     @merchant4 = Merchant.create(name: Faker::Name.name, id: 4)
     @merchant5 = Merchant.create(name: Faker::Name.name, id: 5)
     @merchant6 = Merchant.create(name: Faker::Name.name, id: 6)
     @merchant7 = Merchant.create(name: Faker::Name.name, id: 7)
     @merchant8 = Merchant.create(name: Faker::Name.name, id: 8)
     @merchant9 = Merchant.create(name: Faker::Name.name, id: 9)
     @merchant10 = Merchant.create(name: Faker::Name.name, id: 10)
     @merchant11 = Merchant.create(name: Faker::Name.name, id: 11)
     @merchant12 = Merchant.create(name: Faker::Name.name, id: 12)
     @merchant13 = Merchant.create(name: Faker::Name.name, id: 13)
     @merchant14 = Merchant.create(name: Faker::Name.name, id: 14)
     @merchant15 = Merchant.create(name: Faker::Name.name, id: 15)
     @merchant16 = Merchant.create(name: Faker::Name.name, id: 16)
     @merchant17 = Merchant.create(name: Faker::Name.name, id: 17)
     @merchant18 = Merchant.create(name: Faker::Name.name, id: 18)
     @merchant19 = Merchant.create(name: Faker::Name.name, id: 19)
     @merchant20 = Merchant.create(name: Faker::Name.name, id: 20)
     @merchant21 = Merchant.create(name: Faker::Name.name, id: 21)
     @merchant22 = Merchant.create(name: Faker::Name.name, id: 22)
     @merchant23 = Merchant.create(name: Faker::Name.name, id: 23)
     @merchant24 = Merchant.create(name: Faker::Name.name, id: 24)
     @merchant25 = Merchant.create(name: Faker::Name.name, id: 25)
     @merchant26 = Merchant.create(name: Faker::Name.name, id: 26)
     @merchant27 = Merchant.create(name: Faker::Name.name, id: 27)
     @merchant28 = Merchant.create(name: Faker::Name.name, id: 28)
     @merchant29 = Merchant.create(name: Faker::Name.name, id: 29)
     @merchant30 = Merchant.create(name: Faker::Name.name, id: 30)
     @merchant31 = Merchant.create(name: Faker::Name.name, id: 31)
     @merchant32 = Merchant.create(name: Faker::Name.name, id: 32)
     @merchant33 = Merchant.create(name: Faker::Name.name, id: 33)
     @merchant34 = Merchant.create(name: Faker::Name.name, id: 34)
     @merchant35 = Merchant.create(name: Faker::Name.name, id: 35)
     @merchant36 = Merchant.create(name: Faker::Name.name, id: 36)
     @merchant37 = Merchant.create(name: Faker::Name.name, id: 37)
     @merchant38 = Merchant.create(name: Faker::Name.name, id: 38)
     @merchant39 = Merchant.create(name: Faker::Name.name, id: 39)
     @merchant40 = Merchant.create(name: Faker::Name.name, id: 40)
     @merchant41 = Merchant.create(name: Faker::Name.name, id: 41)
     @merchant42 = Merchant.create(name: Faker::Name.name, id: 42)
     @merchant43 = Merchant.create(name: Faker::Name.name, id: 43)
     @merchant44 = Merchant.create(name: Faker::Name.name, id: 44)
     @merchant45 = Merchant.create(name: Faker::Name.name, id: 45)
     @merchant46 = Merchant.create(name: Faker::Name.name, id: 46)
     @merchant47 = Merchant.create(name: Faker::Name.name, id: 47)
     @merchant48 = Merchant.create(name: Faker::Name.name, id: 48)
     @merchant49 = Merchant.create(name: Faker::Name.name, id: 49)
     @merchant50 = Merchant.create(name: Faker::Name.name, id: 50)
   end
    describe "GET index method" do
      it 'gets a successful response' do
        get api_v1_merchants_url, headers: valid_headers, as: :json
        expect(response).to be_successful
        expect(response).to have_http_status(200)
        body = JSON.parse(response.body, symbolize_names: true)
        expect(body[:data]).to be_an(Array)
        expect(body[:data].first.class).to eq(Hash)
      end
      
      it "renders only 20" do
        get api_v1_merchants_url, headers: valid_headers, as: :json
        expect(response).to be_successful
        body = JSON.parse(response.body, symbolize_names: true)
        expect(body[:data].size).to eq(20)
        expect(body[:data]).to be_an(Array)
      end

      it 'can fetch first page of 50 merchants' do
        merchants = Merchant.all
        get '/api/v1/merchants?per_page=50', headers: valid_headers, as: :json
        expect(response).to be_successful
        body = JSON.parse(response.body, symbolize_names: true)
        expect(body[:data].size).to eq(50)
        expect(body[:data].first[:id].to_i).to eq(merchants.first.id)
        expect(body[:data].last[:id].to_i).to eq(merchants[49].id)
      end

      it "fetches the first 20 for Merchants in the db for page 1" do
        get api_v1_merchants_url, headers: valid_headers, as: :json
        expect(response).to be_successful
        body = JSON.parse(response.body, symbolize_names: true)
        expect(body[:data][0][:attributes][:name]).to eq(@merchant1.name)
        expect(body[:data][19][:attributes][:name]).to eq(@merchant20.name)
      end

      it "fetches the first 20 for Merchants in the db for page 2" do
        get '/api/v1/merchants?page=2&per_page=20', headers: valid_headers, as: :json
        expect(response).to be_successful
        body = JSON.parse(response.body, symbolize_names: true)
        expect(body[:data][0][:attributes][:name]).to eq(@merchant21.name)
        expect(body[:data][19][:attributes][:name]).to eq(@merchant40.name)
      end

      it 'fetches page 1 if page 0 or lower' do
        get '/api/v1/merchants?page=0&per_page=20', headers: valid_headers, as: :json
        expect(response).to be_successful
        body = JSON.parse(response.body, symbolize_names: true)
        expect(body[:data][0][:attributes][:name]).to eq(@merchant1.name)
        expect(body[:data][19][:attributes][:name]).to eq(@merchant20.name)
      end
    end

    describe "GET show method" do
      it 'can get a singular merchant' do
        get "/api/v1/merchants/#{@merchant1.id}", headers: valid_headers, as: :json
        expect(response).to be_successful
        body = JSON.parse(response.body, symbolize_names: true)
        expect(body[:data][:attributes][:name]).to eq(@merchant1.name)
        expect(body[:data][:id]).to eq(@merchant1.id.to_s)
      end

      it 'returns a 404 if the merchant id does not exist' do
        get "/api/v1/merchants/2222", headers: valid_headers, as: :json
        expect(response).to have_http_status(404)
        expect(response.body).to eq("{\"data\":{},\"error\":\"Couldn't find Merchant with 'id'=2222\",\"status\":404}")
      end
    end
end
