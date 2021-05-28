class Api::V1::Items::SearchController < ApplicationController
  def index
    @item = Item.find_items(params[:name])
    if @item.present?
      render json: ItemSerializer.new(@item)
    else
      render json: {data: [], error: "No match found"}, status: 404
    end
  end
end
