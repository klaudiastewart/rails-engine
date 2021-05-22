class Item < MerchantAndItem
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :bulk_discounts, through: :merchant

  validates_presence_of :name, :description, :unit_price, :merchant_id

  # enum status: [:disabled, :enabled]
end
