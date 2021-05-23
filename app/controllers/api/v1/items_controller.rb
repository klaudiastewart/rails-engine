class Api::V1::ItemsController < ApplicationController
  def index
    @all_items = Item.paginations(params[:page], params[:per_page])
    render json: ItemSerializer.new(@all_items)
  end

  def show
    @item = Item.find(params[:id])
    render json: ItemSerializer.new(@item)
  end
end
