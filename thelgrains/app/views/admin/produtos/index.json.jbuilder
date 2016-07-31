json.array!(@produtos) do |produto|
  json.extract! produto, :id
  json.url admin_produto_url(produto, format: :json)
end
