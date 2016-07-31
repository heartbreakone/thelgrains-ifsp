json.array!(@funcionarios) do |f|
  json.nome f.nome
  json.id f.user.id
end
