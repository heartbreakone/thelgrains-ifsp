# == Schema Information
#
# Table name: saidas
#
#  id         :integer          not null, primary key
#  nome       :string
#  descricao  :text
#  valor      :decimal(, )
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

##
# Model para tabela _saidas_.
class Saida < ActiveRecord::Base
end
