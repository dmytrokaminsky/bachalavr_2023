class ApplicationController < ActionController::Base
  include Pundit
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = t('titles.denied')
    redirect_to(request.referrer || root_path)
    logger.debug "==== \033[31mUser not authorized\033[0m ===="
  end

  protected
    # add login field to devise
    #
    def configure_permitted_parameters
      attributes = %i[login email]
      devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
      devise_parameter_sanitizer.permit(:account_update, keys: attributes)
    end

end
