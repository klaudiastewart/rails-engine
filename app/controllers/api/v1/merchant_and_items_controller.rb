class Api::V1::MerchantAndItemsController < ApplicationController
  def index
    return bad_params_400("Invalid quantity") if !params[:quantity].present? || params[:quantity].count("a-zA-Z") > 0
    # @merchants = Merchant.items_sold(params[:quantity])
    @merchants = Merchant.merchants_items_sold(params[:quantity])
    render json: MerchantItemSerializer.new(@merchants)
  end

  def show
    return record_not_found("No id entered") if !params[:merchant_id] && !params[:item_id]
    if params.include?(:merchant_id)
      if !Merchant.find_by_id(params[:merchant_id]).nil?
        @merchant = Merchant.find(params[:merchant_id])
        @merchant_items = @merchant.items
        render json: ItemSerializer.new(@merchant_items)
      else
        return record_not_found("Record not found")
      end
    else
      if !Item.find_by_id(params[:item_id]).nil?
        @item = Item.find_by_id(params[:item_id])
        @item_merchant = @item.merchant
        render json: MerchantSerializer.new(@item_merchant)
      else
        return record_not_found("Item record not found")
      end
    end
  end
end
