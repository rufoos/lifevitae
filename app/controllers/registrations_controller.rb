class RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_user!, :redirect_unless_admin, only: [:new, :create]
  skip_before_action :require_no_authentication

  clear_respond_to
  respond_to :json

  private

  def redirect_unless_admin
    # head :unauthorized unless current_user.try(:admin?)
  end

  def sign_up(resource_name, resource)
    sign_in(resource_name, resource)
  end
end
