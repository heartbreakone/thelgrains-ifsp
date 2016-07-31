json.array!(@clientes) do |cliente|
  json.extract! cliente, :id
  json.url admin_cliente_url(cliente, format: :json)
end
