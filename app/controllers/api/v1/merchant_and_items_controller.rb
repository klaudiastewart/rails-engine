class Api::V1::MerchantAndItemsController < ApplicationController
  def show
    # require "pry"; binding.pry
    if params.include?(:merchant_id)
      @merchant = Merchant.find(params[:merchant_id])
      @merchant_items = @merchant.items
      render json: ItemSerializer.new(@merchant_items)
    else
      @item = Item.find(params[:item_id])
      @item_merchant = @item.merchant
      render json: MerchantSerializer.new(@item_merchant)
    end
    #does this automatically send a 404 if the id isn't in db?
  end
end
