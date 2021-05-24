class Api::V1::ItemsController < ApplicationController
  def index
    @all_items = Item.paginations(params[:page], params[:per_page])
    render json: ItemSerializer.new(@all_items)
  end

  def show
    record_not_found("No id entered") if !params[:id]
    if !Item.find_by_id(params[:id]).nil?
      @item = Item.find(params[:id])
      render json: ItemSerializer.new(@item)
    else
      return record_not_found("Record not found")
    end
  end

  def create
    record_not_found("Record not found") if !params[:merchant_id]
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.create(item_params)
    if @item.save
      render json: ItemSerializer.new(@item),status: :created, location: api_v1_item_url(@item)
    else
      return record_not_found(@item.errors.full_messages)
    end
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    if @item.save
      render json: ItemSerializer.new(@item), status: 200, location: api_v1_item_url(@item)
    else
      return bad_params(@item.errors.full_messages)
    end
  end

  def destroy
    bad_params("Invalid parameters") if !params[:id]
    @item = Item.find(params[:id])
    @item.destroy
    render json: {:status => 'success', :message => 'Item has been deleted', :data => @item}.to_json
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end
