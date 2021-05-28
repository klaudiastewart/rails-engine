class Api::V1::Merchants::SearchController < ApplicationController
  def show
    @merchant = Merchant.merchant(params[:name])
    if @merchant.present?
      render json: MerchantSerializer.new(@merchant)
    else
      return record_not_found("This merchant does not exist")
    end
  end
end
