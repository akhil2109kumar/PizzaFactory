class ApplicationController < ActionController::API
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_login

  def check_login
    render json: { message: "Aauthorized Access" } if !current_user.present?
  end

  protected

  def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: %i[user_name])
      devise_parameter_sanitizer.permit(:account_update, keys: %i[user_name])
    end
end
