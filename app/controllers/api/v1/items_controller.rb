class Api::V1::ItemsController < ApplicationController
  def index
    @all_items = Item.paginations(params[:page], params[:per_page])
    render json: ItemSerializer.new(@all_items)
  end
end
