class SidesController < ApplicationController
  before_action :set_side, only: [:show, :update]

  def create
    @side = Side.new(side_params)
    if @side.save
      return render json: { data: @side }, status: :created
    else
      return render json: { errors: @side.errors }, status: :unprocessable_entity
    end
  end

  def show
    if @side.present?
      return render json: { data: @side }
    else
      return render json: { message: "Side not found" }
    end
  end

  def update
    return render json: { message: "Side not found" } if !@side.present?
    if @side.update(side_params)
      return render json: { data: @side }
    else
      return render json: { errors: @side.errors }, status: :unprocessable_entity
    end
  end

  private

  def set_side
    @side = Side.find_by(id: params[:id])
  end

  def side_params
    params.require(:side).permit(:name, :price)
  end
end
