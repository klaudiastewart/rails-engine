require 'rails_helper'

describe 'ItemRevenuesController', type: :request do
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
    @item3 = @merchant2.items.create(name: '324', description: Faker::Lorem.sentence , unit_price: 3)
    @item4 = @merchant2.items.create(name: 'ter', description: Faker::Lorem.sentence , unit_price: 3)
    @item5 = @merchant2.items.create(name: 'asd', description: Faker::Lorem.sentence , unit_price: 3)
    @item6 = @merchant2.items.create(name: 'fwer', description: Faker::Lorem.sentence , unit_price: 3)
    @item7 = @merchant2.items.create(name: 'gdfg', description: Faker::Lorem.sentence , unit_price: 3)
    @item8 = @merchant2.items.create(name: 'wer', description: Faker::Lorem.sentence , unit_price: 3)
    @item9 = @merchant2.items.create(name: 'dsf', description: Faker::Lorem.sentence , unit_price: 3)
    @item10 = @merchant2.items.create(name: 'aza', description: Faker::Lorem.sentence , unit_price: 3)
    @item11 = @merchant2.items.create(name: 'soda', description: Faker::Lorem.sentence , unit_price: 300)
    @item12 = @merchant2.items.create(name: 'pop', description: Faker::Lorem.sentence , unit_price: 340)

    @invoice1 = Invoice.create(customer_id: @customer1.id, merchant_id: @merchant1.id, status: 'shipped')
    @invoice2 = Invoice.create(customer_id: @customer2.id, merchant_id: @merchant2.id, status: 'shipped')
    @invoice3 = Invoice.create(customer_id: @customer1.id, merchant_id: @merchant1.id, status: 'shipped')

    @invoice_item1 = InvoiceItem.create(item: @item1, invoice: @invoice1, quantity: 1, unit_price: 1)
    @invoice_item2 = InvoiceItem.create(item: @item2, invoice: @invoice2, quantity: 1, unit_price: 1)
    @invoice_item3 = InvoiceItem.create(item: @item3, invoice: @invoice2, quantity: 1, unit_price: 1)
    @invoice_item4 = InvoiceItem.create(item: @item12, invoice: @invoice3, quantity: 1, unit_price: 1)
    @invoice_item5 = InvoiceItem.create(item: @item11, invoice: @invoice3, quantity: 1, unit_price: 10)
    @invoice_item6 = InvoiceItem.create(item: @item12, invoice: @invoice2, quantity: 1, unit_price: 5)

    @transaction1 = Transaction.create(invoice: @invoice1, credit_card_number: '123456789', credit_card_expiration_date: '01/01', result: "success")
    @transaction2 = Transaction.create(invoice: @invoice2, credit_card_number: '123456789', credit_card_expiration_date: '01/01', result: "success")
    @transaction3 = Transaction.create(invoice: @invoice3, credit_card_number: '123456789', credit_card_expiration_date: '01/01', result: "success")
  end

  describe "GET call" do
    it 'gets top query items by revenue' do
      get '/api/v1/revenue/items?quantity=5', headers: valid_headers, as: :json
      expect(response).to be_successful
      expect(response).to have_http_status(200)
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:data]).to be_an(Array)
      expect(body[:data].count).to eq(5)
      expect(body[:data].first[:attributes][:name]).to eq(@item11.name)
      expect(body[:data].last[:attributes][:name]).to eq(@item3.name)
    end

    it 'returns all items by revenue if query param is too long' do
      get '/api/v1/revenue/items?quantity=50000', headers: valid_headers, as: :json
      expect(response).to be_successful
      expect(response).to have_http_status(200)
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:data].count).to eq(5)
    end

    it 'sends a error if quantity is lower than zero' do
      get '/api/v1/revenue/items?quantity=-5', headers: valid_headers, as: :json
      expect(response).to have_http_status(400)
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:error]).to eq('Invalid params')
    end

    it 'sends a 404 error if quantity is blank' do
      get '/api/v1/revenue/items?quantity=', headers: valid_headers, as: :json
      expect(response).to have_http_status(400)
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:error]).to eq('Invalid params')
    end

    it 'sends a 404 if quantity is stringed' do
      get "/api/v1/revenue/items?quantity='5'", headers: valid_headers, as: :json
      expect(response).to have_http_status(400)
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:error]).to eq('Invalid params')
    end
  end
end
