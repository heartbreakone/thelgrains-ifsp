# == Schema Information
#
# Table name: produtos
#
#  id         :integer          not null, primary key
#  nome       :string
#  valor      :decimal(, )
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

##
# Model para tabela _produtos_.
class Produto < ActiveRecord::Base
  validates_presence_of :nome, :valor
  validates_numericality_of :valor,  greater_than: 0
end
