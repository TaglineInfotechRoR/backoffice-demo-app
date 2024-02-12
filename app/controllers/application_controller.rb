class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource_or_scope)
    p ":::::::::after sign in called::::::::"
    if params[:redirect_url].present?
      current_user.generate_and_save_verify_token if current_user.verify_token.nil?
      return "#{params[:redirect_url]}?token=#{current_user.verify_token}"
    else
      super
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:firstname, :lastname])
  end

end
