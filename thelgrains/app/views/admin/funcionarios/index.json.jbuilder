json.array!(@funcionarios) do |funcionario|
  json.extract! funcionario, :id
  json.url admin_funcionario_url(funcionario, format: :json)
end
