class Api::V1::MerchantsController < ApplicationController
  def index
    @all_merchants = Merchant.paginations(params[:page], params[:per_page])
    render json: MerchantSerializer.new(@all_merchants)
  end

  def show
    record_not_found("No id entered") if !params[:id]
    if !Merchant.find(params[:id]).nil?
      @merchant = Merchant.find(params[:id])
      render json: MerchantSerializer.new(@merchant)
    else
      return record_not_found("Record not found")
    end
  end
end
