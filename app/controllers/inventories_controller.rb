class InventoriesController < ApplicationController
  def add_quantity
    item = Inventory.find_by(item_type: params[:item_type], item_id: params[:item_id])
    if item
      item.update(quantity: item.quantity + params[:quantity].to_i)
      render json: { success: true, item: item }, status: :ok
    else
      render json: { success: false, message: 'Item not found' }, status: :not_found
    end
  end

  def reduce_quantity
    item = Inventory.find_by(item_type: params[:item_type], item_id: params[:item_id])
    if item
      new_quantity = [item.quantity - params[:quantity].to_i, 0].max
      item.update(quantity: new_quantity)
      render json: { success: true, item: item }, status: :ok
    else
      render json: { success: false, message: 'Item not found' }, status: :not_found
    end
  end

  def inventory
  	return render json: {data: InventorySerializer.new(Inventory.all)}
  end
end

