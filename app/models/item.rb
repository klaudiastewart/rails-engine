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

  def self.total_revenue(quantity)
    # require "pry"; binding.pry
    joins(:transactions).
    where('transactions.result = ?', 'success').
    select('items.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue').
    group(:id).
    order('revenue desc').
    limit(quantity)
  end

  def total_revenue
    transactions.
    where('transactions.result = ?', 'success').
    pluck("sum(invoice_items.quantity * invoice_items.unit_price)")
  end

  def revenue
    if total_revenue.empty?
      return 0
    else
      return total_revenue.first
    end
  end
end
