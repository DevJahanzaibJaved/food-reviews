class ApplicationController < ActionController::Base
  include Authentication

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  helper_method :current_user, :authenticated?

  private

  def current_user
    Current.user if authenticated?
  end

  def require_admin
    redirect_to root_path, alert: "You don't have permission to access this page." unless current_user&.admin?
  end

  def require_restaurant_owner
    redirect_to root_path, alert: "You don't have permission to access this page." unless current_user&.restaurant_owner?
  end
end
