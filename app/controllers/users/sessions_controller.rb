class Users::SessionsController < Devise::SessionsController
  include RackSessionsFix
  
  respond_to :json

  private

  def respond_with(current_user, _opts = {})
    render json: {
      status: {
        code: 200, message: "Logged in successfully.",
        data: { user: UserSerializer.new(current_user).serializable_hash[:data][:attributes] }
      }
    }, status: :ok
  end

  def respond_to_on_destroy
    if request.headers["Authorization"].present?
      jwt_payload = JWT.decode(request.headers["Authorization"].split(" ").last, "a7039753ade7e5cc9b88972637a7083a60e900e4a69f05051e6050afe484fbd3cb4116c1c6d84930cf241348dfebcb6cc63abda4eb43b217e14dc5e1b3b40941").first
      current_user = User.find(jwt_payload["sub"])
    end

    if current_user
      render json: {
        status: 200,
        message: "Logged out successfully."
      }, status: :ok
    else
      render json: {
        status: 401,
        message: "Couldn't find an active session."
      }, status: :unauthorized
    end
  end
end
