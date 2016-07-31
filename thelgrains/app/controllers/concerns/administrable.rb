##
# Módulo para o namespace Admin.
# Contém comportamentos e métodos comuns.
module Administrable
  extend ActiveSupport::Concern
  include Devise::Controllers::Helpers

  included do
    before_action :authenticate_admin_user!
    prepend_before_filter :verify_admin
    layout 'admin'
  end

  private

  ##
  # Verifica se o usuário é administrador, se não for, desloga e redireciona ao login.
  def verify_admin
    return unless current_admin_user
    unless current_admin_user.admin?
      sign_out :admin_user
      redirect_to new_admin_user_session_path, alert: 'Você não tem permissão de acesso.'
    end
  end
end
