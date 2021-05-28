require 'rails_helper'

RSpec.describe 'MerchantAndItemsController', type: :request do
  let(:valid_headers) {
     {"CONTENT_TYPE" => "application/json"}
     {"Etag" => "f22061f294b256cf0e04fa4d150cee30"}
     {"Cache-Control" => "max-age=0, private, must-revalidate"}
     {"X-Request-id" => "aab43c90-7f82-4ec7-9101-6a22b6e341e4"}
     {"X-Runtime" => "0.095101"}
     {"Transfer-Encoding" => "chunked"}
   }
  before(:each) do
    #with factories...

    # @merchant = create(:merchant), to make a bunch, create_list(:merchant, 100)
    # before :each do
      # @merchant = create(:merchant)
      # create_list(:item, 6, merchant: @merchant)
    # end

    #without...

    @merchant1 = Merchant.create(name: Faker::Name.name, id: 1)
    @merchant2 = Merchant.create(name: 'ab', id: 2)
    @merchant3 = Merchant.create(name: 'abc', id: 3)
    @merchant4 = Merchant.create(name: 'abcd', id: 4)
    @merchant5 = Merchant.create(name: 'abcdE', id: 5)

    @customer1 = Customer.create(first_name: 'Big', last_name: 'Bird')
    @customer2 = Customer.create(first_name: 'Mr.', last_name: 'Grinch')

    @item1 = @merchant1.items.create(name: Faker::Vehicle.make, description: Faker::Lorem.sentence , unit_price: 1)
    @item2 = @merchant1.items.create(name: Faker::Vehicle.make, description: Faker::Lorem.sentence , unit_price: 2)
    @item3 = @merchant1.items.create(name: Faker::Vehicle.make, description: Faker::Lorem.sentence , unit_price: 3)
    @item4 = @merchant2.items.create(name: 'ter', description: Faker::Lorem.sentence , unit_price: 3)
    @item5 = @merchant2.items.create(name: 'asd', description: Faker::Lorem.sentence , unit_price: 3)
    @item6 = @merchant5.items.create(name: 'fwer', description: Faker::Lorem.sentence , unit_price: 3)
    @item7 = @merchant2.items.create(name: 'gdfg', description: Faker::Lorem.sentence , unit_price: 3)
    @item8 = @merchant1.items.create(name: 'wer', description: Faker::Lorem.sentence , unit_price: 3)
    @item9 = @merchant3.items.create(name: 'dsf', description: Faker::Lorem.sentence , unit_price: 3)
    @item10 = @merchant4.items.create(name: 'aza', description: Faker::Lorem.sentence , unit_price: 3)

    @invoice1 = Invoice.create(customer_id: @customer1.id, merchant_id: @merchant1.id, status: 'shipped')
    @invoice2 = Invoice.create(customer_id: @customer2.id, merchant_id: @merchant2.id, status: 'shipped')
    @invoice3 = Invoice.create(customer_id: @customer1.id, merchant_id: @merchant3.id, status: 'shipped')
    @invoice4 = Invoice.create(customer_id: @customer1.id, merchant_id: @merchant4.id, status: 'shipped')
    @invoice5 = Invoice.create(customer_id: @customer2.id, merchant_id: @merchant5.id, status: 'shipped')
    @invoice6 = Invoice.create(customer_id: @customer2.id, merchant_id: @merchant2.id, status: 'shipped')

    @invoice_item1 = InvoiceItem.create(item: @item1, invoice: @invoice1, quantity: 12, unit_price: 10)
    @invoice_item2 = InvoiceItem.create(item: @item2, invoice: @invoice2, quantity: 11, unit_price: 14)
    @invoice_item3 = InvoiceItem.create(item: @item10, invoice: @invoice3, quantity: 14, unit_price: 13)
    @invoice_item4 = InvoiceItem.create(item: @item4, invoice: @invoice4, quantity: 1, unit_price: 21)
    @invoice_item5 = InvoiceItem.create(item: @item6, invoice: @invoice5, quantity: 117, unit_price: 10)
    @invoice_item6 = InvoiceItem.create(item: @item2, invoice: @invoice6, quantity: 187, unit_price: 35)

    @transaction1 = Transaction.create(invoice: @invoice1, credit_card_number: '123456789', credit_card_expiration_date: '01/01', result: "success")
    @transaction2 = Transaction.create(invoice: @invoice2, credit_card_number: '123456789', credit_card_expiration_date: '01/01', result: "success")
    @transaction3 = Transaction.create(invoice: @invoice3, credit_card_number: '123456789', credit_card_expiration_date: '01/01', result: "success")
    @transaction4 = Transaction.create(invoice: @invoice4, credit_card_number: '123456789', credit_card_expiration_date: '01/01', result: "success")
    @transaction5 = Transaction.create(invoice: @invoice5, credit_card_number: '123456789', credit_card_expiration_date: '01/01', result: "success")
    @transaction6 = Transaction.create(invoice: @invoice6, credit_card_number: '123456789', credit_card_expiration_date: '01/01', result: "success")
  end

  describe 'GET single merchants items' do
    it 'gets a successful response' do
      get "/api/v1/merchants/#{@merchant1.id}/items", headers: valid_headers, as: :json
      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:data].size).to eq(4)
      expect(body[:data].first.class).to eq(Hash)
    end

    it 'fetches all items for a merchant' do
      get "/api/v1/merchants/#{@merchant1.id}/items", headers: valid_headers, as: :json
      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:data].first[:attributes][:name]).to eq(@item1.name)
      expect(body[:data].first[:attributes][:description]).to eq(@item1.description)
      expect(body[:data].first[:attributes][:unit_price]).to eq(@item1.unit_price)
      expect(body[:data].last[:attributes][:name]).to eq(@item8.name)
      expect(body[:data].last[:attributes][:description]).to eq(@item8.description)
      expect(body[:data].last[:attributes][:unit_price]).to eq(@item8.unit_price)
    end

    it 'gives status 404 if merchant id not found' do
      get "/api/v1/merchants/100000/items", headers: valid_headers, as: :json
      expect(response.status).to be(404)
      expect(response.body).to eq("{\"data\":{},\"error\":\"Record not found\",\"status\":404}")
    end
  end

  describe 'GET single item merchant' do
    it 'gets a successful response' do
      get "/api/v1/items/#{@item1.id}/merchant", headers: valid_headers, as: :json
      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:data].size).to eq(3)
      expect(body[:data].first.class).to eq(Array)
    end

    it 'fetches all the items merchant' do
      get "/api/v1/items/#{@item1.id}/merchant", headers: valid_headers, as: :json
      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:data][:attributes][:name]).to eq(@merchant1.name)
    end

    it 'gives status 404 if merchant id not found' do
      get "/api/v1/items/1/merchant", headers: valid_headers, as: :json
      expect(response.status).to be(404)
      expect(response.body).to eq("{\"data\":{},\"error\":\"Item record not found\",\"status\":404}")
    end
  end

  describe 'GET merchants who sold most items' do
    it 'fetches top quantity merchants by items sold' do
      get "/api/v1/merchants/most_items?quantity=3", headers: valid_headers, as: :json
      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:data].size).to eq(3)
      expect(body[:data].first.class).to eq(Hash)
      expect(body[:data].first[:id].to_i).to eq(@merchant1.id)
      expect(body[:data].second[:id].to_i).to eq(@merchant5.id)
      expect(body[:data].last[:id].to_i).to eq(@merchant4.id)
    end

    it 'fetches all merchants if quantity is too large' do
      get "/api/v1/merchants/most_items?quantity=300000", headers: valid_headers, as: :json
      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:data].size).to eq(4)
    end

    it 'gives status 404 if quantity is blank' do
      get "/api/v1/merchants/most_items?quantity=", headers: valid_headers, as: :json
      expect(response.status).to be(400)
      expect(response.body).to eq("{\"data\":{},\"error\":\"Invalid quantity\",\"status\":400}")
    end

    it 'gives status 404 is quantity is missing in query' do
      get "/api/v1/merchants/most_items", headers: valid_headers, as: :json
      expect(response.status).to be(400)
      expect(response.body).to eq("{\"data\":{},\"error\":\"Invalid quantity\",\"status\":400}")
    end
  end
end
