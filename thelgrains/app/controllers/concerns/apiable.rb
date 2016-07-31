##
# Módulo para o namespace Admin.
# Contém comportamentos e métodos comuns.
module Apiable
  extend ActiveSupport::Concern
  include Devise::Controllers::Helpers

  included do
    layout nil
    # before_action :authenticate_api_user!
    skip_before_action :verify_authenticity_token
    clear_respond_to
    respond_to :json
  end
end
