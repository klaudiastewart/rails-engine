class Api::V1::ItemsController < ApplicationController
  def index
    @all_items = Item.paginations(params[:page], params[:per_page])
    render json: ItemSerializer.new(@all_items)
  end

  def show
    @item = Item.find(params[:id])
    render json: ItemSerializer.new(@item)
    # render :json => {:error => "not-found"}.to_json, :status => 404
    # render json: {:status => 'success', :message => 'Item has been deleted', :data => @item}.to_json
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.create(item_params)
    if @item.save
      render json: ItemSerializer.new(@item),status: :created, location: api_v1_item_url(@item)
    else
      render json: ItemSerializer.new(@item).errors, status: :unproccessable_entity
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    render json: {:status => 'success', :message => 'Item has been deleted', :data => @item}.to_json
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end
