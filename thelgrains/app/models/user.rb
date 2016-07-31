# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  cpf                :string(11)       not null
#  encrypted_password :string           not null
#  admin              :boolean          default(FALSE)
#  active             :boolean          default(TRUE)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'cpf'

##
# Model para tabela _users_
class User < ActiveRecord::Base
  include Cpf
  include TokenAuthenticable

  # before_create :generate_authentication_token

  devise :database_authenticatable, :timeoutable, authentication_keys: [:cpf]

  has_one :funcionario, inverse_of: :user
  has_many :atendimentos, inverse_of: :user
  has_many :ajudantes, inverse_of: :user
  has_many :agendamentos, inverse_of: :user

  validates :cpf, presence: true, uniqueness: true
  validates :password, confirmation: true, length: { minimum: 8 }, if: -> { new_record? || !password.nil? }
  validates :password_confirmation, presence: true,  if: -> { new_record? || !password.nil? }
  validates_associated :funcionario

  accepts_nested_attributes_for :funcionario, :agendamentos, :atendimentos

  def entradas_entre(inicio, fim)
    e = Entrada.where(created_at: inicio..fim)
    e.joins(:atendimento).where(user: self)
  end

  ##
  # Interface para método funcionario#nome
  def nome
    funcionario.nome
  end

  def nome_ultimo
    funcionario.nome_ultimo
  end
end
