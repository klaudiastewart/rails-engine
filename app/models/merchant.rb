require 'ostruct' # creates dummy object 
class Merchant < MerchantAndItem
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  validates_presence_of :name

  # enum status: [:disabled, :enabled]

  def self.merchant(name)
    where('name ILIKE ?', "%#{name}%").
    first
  end

  def self.merchants(name)
    where('name ILIKE ?', "%#{name}%")
  end

  def self.total_revenue(quantity)
    joins(:transactions)
    .select('merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) as revenue')
    .where('transactions.result = ?', 'success')
    .group(:id)
    .order(revenue: :desc)
    .limit(quantity)
  end

  def single_revenue
    transactions.
    where(result: :success).
    pluck('sum(invoice_items.quantity * invoice_items.unit_price) as revenue').
    first
  end

  def self.items_sold(quantity)
    joins(invoice_items: :transactions)
    .where('invoices.status = ?', 'shipped')
    .where('transactions.result = ?', 'success')
    .select('merchants.*, sum(invoice_items.quantity) as items_quantity')
    .group(:id)
    .order('items_quantity desc')
    .limit(quantity)
  end

  def items_sold
    transactions.
    where('transactions.result = ?', 'success').
    pluck("sum(invoice_items.quantity)").
    first
  end

  def self.merchants_items_sold(quantity)
    items_sold(quantity).map do |merchant|
      OpenStruct.new(
        name: merchant.name,
        count: merchant.items_sold,
        id: merchant.id
      )
    end
  end
end
