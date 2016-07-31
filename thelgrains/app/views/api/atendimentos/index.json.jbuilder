json.array(@atendimentos) do |c|
  json.id c.id
  json.servico c.servico.nome
  json.created_at c.created_at
end
