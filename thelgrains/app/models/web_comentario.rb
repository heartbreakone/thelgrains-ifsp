# == Schema Information
#
# Table name: web_comentarios
#
#  id         :integer          not null, primary key
#  nome       :string           not null
#  email      :string           not null
#  comentario :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

##
# Model para tabela web_comentarios
class WebComentario < ActiveRecord::Base
  validates_presence_of :nome, :email, :comentario
  validates :comentario, length: { minimum: 5, maximum: 500 }
  # validate :limite_de_comentario

  private

  ##
  # Valida se foi ultrapassado o limite de comentários.
  def limite_de_comentario
    # OPTIMIZE, still uses bd querys
    n = Rails.configuration.comentarios_limite_n # quantidade limite de comentarios (exclusive)
    t = Rails.configuration.comentarios_tempo_min # tempo em minutos (exclusive)
    query = WebComentario.where('updated_at > ? AND email = ?', t.minutes.ago, email) # :updated_at > t.minutes.ago, email: email
    puts(query.size)
    return true if query.size < n
    query.each(&:touch) # chama touch para cada objeto na query
    errors.add(:limite_de_comentario, "Aguarde #{t} minutos para comentar!")
  end

end
