json.extract! @atendimento, :id, :user_id, :servico_id, :cliente_id, :gasto_add, :created_at
json.funcionario @atendimento.user.nome
json.cliente @atendimento.cliente.try(:nome) || "<a href='#TODO'>Não Cadastrado</a>".html_safe
count = Hash.new(0)
@atendimento.ajudantes.each { |a| count[a.user.nome] += 1 }
json.ajudantes count do |k, v|
  json.nome k
  json.vezes v
end
json.servico @atendimento.servico.nome
json.servico_preco @atendimento.servico.valor
json.gasto_total @atendimento.valor_a_pagar
