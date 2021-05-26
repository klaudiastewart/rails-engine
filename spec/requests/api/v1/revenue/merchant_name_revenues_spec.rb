require 'rails_helper'

describe 'MerchantNameRevenuesController', type: :request do
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
    @merchant11 = Merchant.create(name: 'lmnoa', id: 11)

    @customer1 = Customer.create(first_name: 'Big', last_name: 'Bird')
    @customer2 = Customer.create(first_name: 'Mr.', last_name: 'Grinch')

    @item1 = @merchant1.items.create(name: 'zaz', description: Faker::Lorem.sentence , unit_price: 1)
    @item2 = @merchant1.items.create(name: 'zza', description: Faker::Lorem.sentence , unit_price: 2)
    @item3 = @merchant2.items.create(name: 'aza', description: Faker::Lorem.sentence , unit_price: 3)

    @invoice1 = Invoice.create(customer_id: @customer1.id, merchant_id: @merchant1.id, status: 'shipped')
    @invoice2 = Invoice.create(customer_id: @customer2.id, merchant_id: @merchant2.id, status: 'shipped')
    @invoice3 = Invoice.create(customer_id: @customer1.id, merchant_id: @merchant1.id, status: 'shipped')

    @invoice_item1 = InvoiceItem.create(item: @item1, invoice: @invoice1, quantity: 1, unit_price: 1)
    @invoice_item2 = InvoiceItem.create(item: @item1, invoice: @invoice2, quantity: 1, unit_price: 1)
    @invoice_item3 = InvoiceItem.create(item: @item2, invoice: @invoice2, quantity: 1, unit_price: 1)
    @invoice_item4 = InvoiceItem.create(item: @item2, invoice: @invoice3, quantity: 1, unit_price: 1)
    @invoice_item5 = InvoiceItem.create(item: @item3, invoice: @invoice3, quantity: 1, unit_price: 10)
    @invoice_item6 = InvoiceItem.create(item: @item3, invoice: @invoice2, quantity: 1, unit_price: 5)

    @transaction1 = Transaction.create(invoice: @invoice1, credit_card_number: '123456789', credit_card_expiration_date: '01/01', result: "success")
    @transaction2 = Transaction.create(invoice: @invoice2, credit_card_number: '123456789', credit_card_expiration_date: '01/01', result: "success")
    @transaction3 = Transaction.create(invoice: @invoice3, credit_card_number: '123456789', credit_card_expiration_date: '01/01', result: "success")
  end

  describe "GET call" do
    it 'gets top one merchant by revenue and top ten merchants by revenue' do
      get '/api/v1/revenue/merchants?quantity=10', headers: valid_headers, as: :json
      expect(response).to be_successful
      expect(response).to have_http_status(200)
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:data]).to be_an(Array)
      expect(body[:data].first[:attributes][:name]).to eq(@merchant2.name)
      expect(body[:data].last[:attributes][:name]).to eq(@merchant1.name)
    end

    it 'fetches all merchants with a transaction if quantity is too large' do
      get '/api/v1/revenue/merchants?quantity=100000000', headers: valid_headers, as: :json
      expect(response).to be_successful
      expect(response).to have_http_status(200)
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:data].size).to eq(2)
    end

    it 'sends an error if quantity value is blank or missing' do
      get '/api/v1/revenue/merchants?quantity=', headers: valid_headers, as: :json
      expect(response).to have_http_status(400)
      expect(response.body).to eq("{\"data\":{},\"error\":\"Invalid params\",\"status\":400}")
    end

    it 'sends an error if quantity value is a string' do
      get "/api/v1/revenue/merchants?quantity='5''", headers: valid_headers, as: :json
      expect(response).to have_http_status(400)
      expect(response.body).to eq("{\"data\":{},\"error\":\"Invalid params\",\"status\":400}")
    end
  end

  describe "Show call" do
    it 'gets one merchants revenue by id' do
      get "/api/v1/revenue/merchants/#{@merchant1.id}", headers: valid_headers, as: :json
      expect(response).to be_successful
      expect(response).to have_http_status(200)
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:data]).to be_an(Hash)
      expect(body[:data][:id].to_i).to eq(@merchant1.id)
      expect(body[:data][:attributes][:revenue]).to eq(@merchant1.single_revenue)
    end

    it 'returns a 404 if the id does not exist' do
      get "/api/v1/revenue/merchants/100000", headers: valid_headers, as: :json
      expect(response.status).to eq(404)
      expect(response.body).to eq("{\"data\":{},\"error\":\"Couldn't find Merchant with 'id'=100000\",\"status\":404}")
    end
  end
end
