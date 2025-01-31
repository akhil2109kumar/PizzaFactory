class DashboardController < ApplicationController
  def index
    render json: { message: "hello #{current_user.user_name}" }
  end
end
