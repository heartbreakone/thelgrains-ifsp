require 'cpf/ext/string_cpf_validator'
require 'cpf/ext/string_cpf_mask'

##
# Módulo de mask e validação de CPF para o +ActiveRecord::Base+.
# Utiliza a classe String extendida em _lib/cpf/ext/_.
module Cpf
  extend ActiveSupport::Concern

  included do
    before_validation :ensure_no_cpf_mask
    validate :cpf_digits
  end

  private

  # Verifica se há máscara no CPF, se houver, remove.
  def ensure_no_cpf_mask
    cpf.remove_cpf_mask! unless cpf.nil?
  end

  # Valida se o CPF tem os dígitos verificadores corretos.
  def cpf_digits
    return if cpf.nil?
    errors.add(:cpf, 'CPF inválido') unless cpf.validate_cpf
  end
end
