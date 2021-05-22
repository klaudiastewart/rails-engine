class MerchantAndItem < ApplicationRecord
  #pagination for merchant and item lives here
  self.abstract_class = true

  def self.paginations(page = nil, per_page = nil)
    page = 1 if page.nil? || page == "0"
    per_page = 20 if per_page.nil?
    self.offset((page.to_i - 1) * per_page.to_i).limit(per_page.to_i)
  end
end
