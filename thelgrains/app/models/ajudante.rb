# == Schema Information
#
# Table name: ajudantes
#
#  id             :integer          not null, primary key
#  atendimento_id :integer          not null
#  user_id        :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

##
# Model da tabela _ajudantes_.
# Tabela Many-to-Many entre _atendimentos_ e _users_.
# Utilizada para contabilização de um +Atendimento+.
class Ajudante < ActiveRecord::Base
  belongs_to :user, inverse_of: :ajudantes
  belongs_to :atendimento, inverse_of: :ajudantes

  ##
  # Cria _ajudantes_ com relação a um +Atendimento+
  # +atendimento+ Atendimento base para criação.
  # +users+ Coleção de +Users+ para criação.
  def self.create_ajudantes_by_atendimento(atendimento, users)
    ActiveRecord::Base.transaction do
      users.each do |u|
        Ajudante.create! user: u, atendimento: atendimento
      end
    end
  end

end
