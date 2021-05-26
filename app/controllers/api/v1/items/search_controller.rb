class Api::V1::Items::SearchController < ApplicationController
  def index
    @item = Item.find_items(params[:name])
    if @item.present?
      render json: ItemSerializer.new(@item)
    else
      render json: {data: [], error: "No match found"}, status: 404
    end
  end

  def show
    @item = Item.find_item(params[:name])
    if @item.present?
      render json: ItemSerializer.new(@item)
    else
      return record_not_found("No matches for query")
    end

    # if params[:min_price].present? || params[:max_price].present?
    #   # require "pry"; binding.pry
    #   @item = Item.find_item_by_price(params[:min_price] || params[:max_price])
    #   render json: ItemSerializer.new(@item)
    # elsif params[:min_price].present? && params[:max_price].present?
    #   @item = Item.find_item_two_prices(params[:min_price] && params[:max_price])
    #   render json: ItemSerializer.new(@item)
    # elsif params[:name].present? && !params[:min_price] && !params[:min_price]
    #   @item = Item.find_item(params[:name])
    #   if @item.present?
    #     render json: ItemSerializer.new(@item)
    #   else
    #     return record_not_found("This item does not exist")
    #   end
    # else params[:max_price].present && params[:max_price] < 0
    #   return record_not_found("Max price cannot be below 0")
    #
    # end
  end
end
