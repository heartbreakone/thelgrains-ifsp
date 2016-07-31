##
# Módulo para autenticação de API via token
# TODO, use auth token for API
module TokenAuthenticable
  extend ActiveSupport::Concern

  ##
  # Gera um novo e único token para autenticação.
  def generate_auth_token!
    begin
      self.authentication_token = SecureRandom.hex
    end while self.class.exists? authentication_token: self.authentication_token
  end

  ##
  # Invalida token atual, gerando um novo.
  def invalid_token!
    return false if self.new_record?
    generate_auth_token unless self.authentication_token.nil?
    self.save
  end
end
