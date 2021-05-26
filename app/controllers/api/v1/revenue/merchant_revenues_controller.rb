class Api::V1::Revenue::MerchantRevenuesController < ApplicationController
  def index
    return bad_params_400("Invalid params") if params[:quantity].to_i == 0 || !params[:quantity].present?
    @merchants = Merchant.total_revenue(params[:quantity])
    render json: MerchantNameRevenueSerializer.new(@merchants)
  end
end
