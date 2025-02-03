class CrustsController < ApplicationController
  before_action :set_crust, only: [:show, :update]

  def create
    @crust = Crust.new(crust_params)
    if @crust.save
      return render json: { data: @crust }, status: :created
    else
      return render json: { errors: @crust.errors }, status: :unprocessable_entity
    end
  end

  def show
    if @crust.present?
      return render json: { data: @crust }
    else
      return render json: { message: "Crust not found" }
    end
  end

  def update
  	return render json: {message: "crust not found"} if !@crust.present?
    if @crust.update(crust_params)
      return render json: { data: @crust }
    else
      return render json: { errors: @crust.errors }, status: :unprocessable_entity
    end
  end

  private

  def set_crust
    @crust = Crust.find_by(id: params[:id])
  end

  def crust_params
    params.require(:crust).permit(:name)
  end
end
