class ToppingsController < ApplicationController
  before_action :set_topping, only: [:show, :update]

  def create
    @topping = Topping.new(topping_params)
    if @topping.save
      return render json: {data: @topping}, status: :created
    else
      return render json: {errors: @topping.errors}, status: :unprocessable_entity
    end
  end

  def show
    if @topping.present?
      return render json: {data: @topping}
    else
      return render json: {message: "topping not found"} 
    end
  end

  def update
    return render json: {message: "topping not found"} if !@topping.present?
    if @topping.update(topping_params)
      return render json: {data: @topping}
    else
      return render json: {errors: @topping.errors}, status: :unprocessable_entity
    end
  end

  private

  def set_topping
    @topping = Topping.find_by(id: params[:id])

  end

  def topping_params
    params.require(:topping).permit(:name, :category, :price)
  end
end
