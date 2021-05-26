class MerchantRevenueSerializer
  include FastJsonapi::ObjectSerializer
  if attributes.empty?
    attributes :revenue do |merchant|
      merchant.single_revenue
    end
  end
end
