class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password) }
  end
end
