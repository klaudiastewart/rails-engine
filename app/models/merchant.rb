class Merchant < MerchantAndItem
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  validates_presence_of :name

  # enum status: [:disabled, :enabled]

  # def self.merchants
    # select(:name, :id)
    # where('name ILIKE ?', "#{'Schroeder-Jerde'}")
  # end
end
