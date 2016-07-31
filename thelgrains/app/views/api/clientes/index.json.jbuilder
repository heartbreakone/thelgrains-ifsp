json.array(@clientes) do |c|
  json.id c.id
  json.nome c.nome
end
