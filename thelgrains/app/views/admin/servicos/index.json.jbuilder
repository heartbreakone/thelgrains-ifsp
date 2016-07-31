json.array!(@servicos) do |servico|
  json.extract! servico, :id
  json.url admin_servico_url(servico, format: :json)
end
