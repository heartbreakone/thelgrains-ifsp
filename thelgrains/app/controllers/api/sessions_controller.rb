require 'cpf'

##
# Módulo que serve via API.
module Api

  ##
  # Controlador de sessão
  class SessionsController < Devise::SessionsController

    before_filter :configure_sign_in_params, only: [:create]
    clear_respond_to
    respond_to :json
    skip_before_action :verify_authenticity_token

    # before_filter :authorize!, except: :new TODO

    # GET /resource/sign_in
    def new
      self.resource = resource_class.new(sign_in_params)
      clean_up_passwords(resource)
      yield resource if block_given?
      render 'api/sessions/status'
    end

    # POST /resource/sign_in
    def create
      flash.clear
      params[:api_user][:cpf].remove_cpf_mask! if params[:api_user]
      self.resource = warden.authenticate!(auth_options)
      set_flash_message(:notice, :signed_in) if is_flashing_format?
      sign_in(resource_name, resource)
      yield resource if block_given?
      session[:rightpass] = true
      render 'api/sessions/status'
    end

    # DELETE /resource/sign_out
    def destroy
      flash.clear
      signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
      set_flash_message :notice, :signed_out if signed_out && is_flashing_format?
      yield if block_given?
      render 'api/sessions/status'
    end

    protected

    # Override the default devise signin/signout process
    def sign_in_and_redirect(resource_or_scope, resource=nil)
      scope = Devise::Mapping.find_scope!(resource_or_scope)
      resource ||= resource_or_scope
      sign_in(scope, resource) unless warden.user(scope) == resource
      # redirect_to stored_location_for(scope) || after_sign_in_path_for(resource)
      render 'api/sessions/status'
    end

    def sign_out_and_redirect(resource_or_scope)
      scope = Devise::Mapping.find_scope!(resource_or_scope)
      if Devise.sign_out_all_scopes
        sign_out_all_scopes
      else
        sign_out(scope)
      end
      #redirect_to after_sign_out_path_for(scope)
      render 'api/sessions/status'
    end

    def require_no_authentication
      assert_is_devise_resource!
      return unless is_navigational_format?
      no_input = devise_mapping.no_input_strategies

      authenticated = if no_input.present?
        args = no_input.dup.push scope: resource_name
        warden.authenticate?(*args)
      else
        warden.authenticated?(resource_name)
      end

      if authenticated && resource = warden.user(resource_name)
        # CHANGE THE FOLLOWING LINES AS NEEDED
        flash[:alert] = I18n.t("devise.failure.already_authenticated")
        render 'api/sessions/status'
      end
    end

    # If you have extra params to permit, append them to the sanitizer.
    def configure_sign_in_params
      devise_parameter_sanitizer.for(:sign_in) << :cpf
    end

    private

    # IDEA, autoriazar via token
    def authorize!
      authenticate_or_request_with_http_token do |token, options|
        User.find_by_cpf(params[:id]).authorization_token == token
      end
    end
  end
end
