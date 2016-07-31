require 'bcrypt'
module Web

  ##
  # Controlador de sessão da interface web.
  class SessionsController < ApplicationController
    include Webable

    skip_before_action :require_login, only: [:new, :create]

    # GET em /login
    def new
      redirect_to home_path if logged_in?
    end

    # POST em /login
    def create
      # SEMPRE USE BCrypt
      if BCrypt::Password.new(Rails.application.secrets.web_password.to_s) == params[:password]
        session[:id] = 'web'
        redirect_to home_path, notice: 'Logado com sucesso!'
      else
        redirect_to login_path, alert: 'Senha incorreta!'
      end
    end

    # POST GET DESTROY em /logout
    def destroy
      session[:id] = nil
      redirect_to login_path, notice: 'Sessão encerrada!'
    end

    private

    # Whitelist de parâmetros permitidos.
    def user_params
      params.permit(:password)
    end
  end
end
