class Api::BaseController < ActionController::API
  before_action :authenticate_user!

  private

  def authenticate_user!
    api_key = request.headers['Authorization']
    @current_user = User.find_by(api_key: api_key)

    render json: { error: 'Unauthorized' }, status: :unauthorized unless @current_user
  end
end
