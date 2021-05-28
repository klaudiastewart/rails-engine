class ItemRevenueSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :description, :merchant_id, :unit_price

  attributes :revenue do |item|
    item.revenue
  end
end
