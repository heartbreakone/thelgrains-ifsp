require 'cpf'
module Admin

  ##
  # Controlador de sessão via Devise.
  class SessionsController < Devise::SessionsController
    include Administrable

    skip_before_filter :verify_admin

    before_filter :configure_sign_in_params, only: [:create]

    # skip_before_action :authenticate_admin_user!

    # GET /resource/sign_in
    # def new
    #   super
    # end

    # POST /resource/sign_in
    def create
      params[:admin_user][:cpf].remove_cpf_mask!
      super
    end

    # DELETE /resource/sign_out
    # def destroy
    #   super
    # end

    protected

    def after_sign_in_path_for(resource)
      flash[:notice] ||= String.new
      flash[:notice] << '</br>Bem vindo, '.html_safe
      flash[:notice] << current_admin_user.funcionario.nome.split(' ')[0]
      :admin_dashboard # Or :prefix_to_your_route
    end

    def after_sign_out_path_for(resource)
      :admin_user_session # Or :prefix_to_your_route
    end

    # If you have extra params to permit, append them to the sanitizer.
    def configure_sign_in_params
      devise_parameter_sanitizer.for(:sign_in) << :cpf
    end
  end
end
