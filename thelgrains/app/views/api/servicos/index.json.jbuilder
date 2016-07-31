json.array!(@categorias) do |c|
  json.id c.id
  json.nome c.nome
  json.servicos do
    json.array!(c.servicos) do |s|
      json.id s.id
      json.nome s.nome
    end
  end
end
