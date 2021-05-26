class Item < MerchantAndItem
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :bulk_discounts, through: :merchant

  validates_presence_of :name, :unit_price

  # enum status: [:disabled, :enabled]
  def self.find_items(name)
    where("name ILIKE ?", "%#{name}%")
  end

  def self.find_item(name)
    where(["name ILIKE ? or description ILIKE ?", "%#{name}%", "%#{name}%"]).
    # order(:name).
    first
  end
  #
  # def self.find_item_by_price(price)
  #   where("unit_price >= ?", price.to_i).
  #   order(:name).
  #   first
  #   # Item A Error = 2352, $285.96
  # end
  #
  # def self.find_item_two_prices(min_price, max_price)
  #   where(["unit_price >= ? or unit_price <= ?", "#{min_price.to_i}, #{max_price.to_i}"]).
  #   first
  # end
end
