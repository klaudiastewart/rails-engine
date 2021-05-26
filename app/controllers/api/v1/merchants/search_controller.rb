class Api::V1::Merchants::SearchController < ApplicationController
  def index
    # @all_merchants = Merchant.merchants(params[:name])
    # render json: MerchantSerializer.new(@all_merchants)
  end

  def show
    @merchant = Merchant.merchant(params[:name])
    if @merchant.present?
      render json: MerchantSerializer.new(@merchant)
    else
      return record_not_found("This merchant does not exist")
    end
  end
end
