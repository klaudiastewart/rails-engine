class Api::V1::MerchantsController < ApplicationController
  def index
    @all_merchants = Merchant.paginations(params[:page], params[:per_page])
    render json: MerchantSerializer.new(@all_merchants)
  end
end
