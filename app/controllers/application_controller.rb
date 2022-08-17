class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:lastname, :firstname, :kana_lastname, :kana_firstname, :tel, :postal_code, :address])
    devise_parameter_sanitizer.permit(:account_update, keys: [:lastname, :firstname, :kana_lastname, :kana_firstname, :postal_code, :address, :tel])
  end

end
