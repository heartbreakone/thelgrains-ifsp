##
# Módulo do namespace Web
module Webable
  extend ActiveSupport::Concern

  included do
    clear_respond_to
    respond_to :html, :json
    before_action :require_login
    helper_method :logged_in?
    layout 'web'
  end

  ##
  # Verifica se a sessão está logada.
  def logged_in?
    session[:id] == 'web'
  end

  private

  ##
  # Nega o acesso às páginas se não estiver logado.
  def require_login
    unless logged_in?
      flash[:error] = 'Você deve estar logado para acessar a página!'
      respond_to do |format|
        format.html { redirect_to login_path } # halts request cycle
        format.json { render json: flash , status: :unauthorized }
      end
    end
  end

  # TODO
  def prevent_double_login
    # session[:id] == nil ? session[:id] = nil : true
  end
end
