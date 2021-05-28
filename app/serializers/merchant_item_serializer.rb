class MerchantItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :count 

  # attributes :count do |merchant|
  #   merchant.items_sold
  # end
end
