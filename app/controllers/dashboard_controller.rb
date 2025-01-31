class DashboardController < ApplicationController
	def index
		return render json: {message: "hello #{current_user.user_name}"}
	end
end
