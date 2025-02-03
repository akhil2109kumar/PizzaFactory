class ApplicationController < ActionController::API
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_login, unless: :devise_controller?
  before_action :vendor_role_check, unless: :orders_controller_or_devise_controller?
  before_action :user_role_check, if: :orders_controller?

  def current_user
    jwt_payload = JWT.decode(request.headers["Authorization"].split(" ").last, "a7039753ade7e5cc9b88972637a7083a60e900e4a69f05051e6050afe484fbd3cb4116c1c6d84930cf241348dfebcb6cc63abda4eb43b217e14dc5e1b3b40941").first
    current_user = User.find_by(jti: jwt_payload["jti"])
  end

  def vendor_role_check
    render json: { message: "Unauthorized Access" } if !current_user.present? || ["user", nil].include?(current_user.role)
  end

  def user_role_check
    render json: { message: "Unauthorized Access" } if !current_user.present? || ["vendor", nil].include?(current_user.role)
  end

  def check_login 
    render json: { message: "Unauthorized Access" } if !current_user.present?
  end

  def orders_controller?
    controller_name == 'orders'
  end

  def orders_controller_or_devise_controller?
    devise_controller? || controller_name == 'orders'
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[user_name role])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[user_name role])
  end
end

