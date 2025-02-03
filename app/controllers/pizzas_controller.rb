class PizzasController < ApplicationController
  before_action :set_pizza, only: [:show, :update]
  
  def create
    pizza = Pizza.new(pizza_params)
    if pizza.save
      return render json: {data: pizza}
    else
      return render json: {errors: pizza.errors.full_messages}
    end
  end

  def update
    return render json: {message: "pizza not found"} if !@pizza.present?
    if @pizza.update(pizza_params)
      return render json: {data: @pizza}
    else
      return render json: {errors: @pizza.errors.full_messages} 
    end

  end

  def show
    if @pizza.present?
      return render json: {data: @pizza}
    else
      return render json: {message: "pizza not found"} 
    end
  end

  private

  def pizza_params
    params.require(:pizza).permit(:name, :category)
  end

  def set_pizza
    @pizza =  Pizza.find_by(id: params[:id])
  end
end
