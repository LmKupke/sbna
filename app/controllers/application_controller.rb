class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_paper_trail_whodunnit
  before_action :configure_permitted_parameters, if: :devise_controller?


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :street_number, :phone_number, :street, :zipcode, :city, :state, :other_address, :profphoto])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :street_number, :phone_number, :street, :zipcode, :city, :state, :other_address, :profphoto])
  end
end
