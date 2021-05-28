class Api::V1::Revenue::ItemRevenuesController < ApplicationController
  def index
    return bad_params_400("Invalid params") if params[:quantity].to_i <= 0 || !params[:quantity].present?
    @items = Item.total_revenue(params[:quantity])
    render json: ItemRevenueSerializer.new(@items)
  end
end
