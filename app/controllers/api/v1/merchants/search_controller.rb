class Api::V1::Merchants::SearchController < ApplicationController
  def index
    @all_merchants = Merchant.merchant_names #(params[:name])
    render json: MerchantSerializer.new(@all_merchants)
  end

  # def show
  #   @merchant = Merchant.merchant_names(params[:name])
  # end
end
