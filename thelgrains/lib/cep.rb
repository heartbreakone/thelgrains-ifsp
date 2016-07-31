require 'cep/ext/string_cep_mask'

##
# Módulo de mask de CEP para o +ActiveRecord::Base+.
# Utiliza a classe String extendida em _lib/cep/ext/_.
module Cep
  extend ActiveSupport::Concern

  included do
    before_validation :ensure_no_cep_mask
  end

  private

  ##
  # Verifica se há máscara no CEP, se houver, remove.
  def ensure_no_cep_mask
    cep.remove_cep_mask! unless cep.nil?
  end
end
