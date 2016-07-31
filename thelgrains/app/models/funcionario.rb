# == Schema Information
#
# Table name: funcionarios
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  nome       :string           not null
#  nascimento :date
#  sexo       :string(1)
#  telefone   :string
#  celular    :string
#  cep        :string(8)
#  endereco   :string
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'cep'

##
# Model para tabela _funcionario_.
class Funcionario < ActiveRecord::Base
  include Cep

  belongs_to :user, inverse_of: :funcionario

  validates_presence_of :user, :nome, :telefone, :endereco, :cep
  validates_length_of :cep, is: 8
  validates_length_of :telefone, is: 10
  validates_length_of :celular, in: 10..11, allow_nil: true
  validates_length_of :endereco, minimum: 10
  validates_numericality_of :telefone, :cep

  accepts_nested_attributes_for :user

  before_create :upcase_sexo
  before_update :upcase_sexo

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

  ##
  # Formata o campo +endereco+ em um Hash.
  def self.strip_endereco(endereco)
    return false unless endereco.is_a? String
    return false unless endereco.contains? ','
    arr = endereco.split(',')
    arr.each { |s| s.strip! }
    hash = Hash.new
    hash[:logradouro] = arr[0]
    hash[:numero] = arr[1]
    hash[:complemento] = arr[2]
    hash[:bairro] = arr[3]
    hash[:cidade] = arr[4]
    hash[:estado] = arr[5]
    hash
  end

  ##
  # Formata o campo +endereco+ em uma String concatenada.
  #   O campo +endreco+ deve ser um Hash.
  def self.concat_endereco(hash)
    return unless endereco.include? '\\'
    e = String.new
    eval(endereco).each { |s|
      e += s[1].gsub(',', '').strip! + ', '
    }
    e
  end

  ##
  # Coloca o campo +sexo+ em upcase.
  def upcase_sexo
    sexo.upcase! if sexo
  end
end
