class Api::V1::Revenue::MerchantRevenuesController < ApplicationController
  def index
    return bad_params_400("Invalid params") if params[:quantity].to_i == 0 || !params[:quantity].present?
    @merchants = Merchant.total_revenue(params[:quantity])
    render json: MerchantNameRevenueSerializer.new(@merchants)
  end

  def show
    return record_not_found("Bad id entered") if params[:id].to_i == 0 || !params[:id].present?
    @merchant = Merchant.find(params[:id])
    render json: MerchantRevenueSerializer.new(@merchant)
  end
end
