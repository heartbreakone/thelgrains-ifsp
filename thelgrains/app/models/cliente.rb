# == Schema Information
#
# Table name: clientes
#
#  id         :integer          not null, primary key
#  nome       :string
#  telefone   :string
#  celular    :string
#  email      :string
#  cpf        :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'cpf'

##
# Model para tabela _clientes_.
class Cliente < ActiveRecord::Base
  include Cpf

  has_many :agendamentos
  has_many :atendimentos

  validates_presence_of :nome, :telefone

  validates_uniqueness_of :cpf, :email, allow_nil: true

  validates_length_of :cpf, is: 11, allow_nil: true
  validates_length_of :telefone, is: 10
  validates_length_of :celular, in: 10..11, allow_nil: true

  validates_format_of :email, with: /.+@.+\..+/i, allow_nil: true
  validates_numericality_of :cpf, :celular, :telefone, allow_nil: true

  def servico_favorito
    servs = Atendimento.where(cliente: self).group(:servico).count
    servs.sort_by { |k,v| v }.reverse.to_h
    servs.first.try(:first).try(:nome) || 'Nenhum'
  end

  ##
  # Retorna o nome e o sobrenome.
  def nome_sobrenome
    primeiro_nome + ' ' + segundo_nome
  end

  def nome_ultimo
    primeiro_nome + ' ' + ultimo_nome
  end

  ##
  # Retorna o primeiro nome.
  def primeiro_nome
    nome.split(' ')[0]
  end

  ##
  # Retorna o segundo nome
  def segundo_nome
    nome.split(' ')[1]
  end

  ##
  # Retorna o último nome.
  def ultimo_nome
    nome.split(' ')[-1]
  end
end
