json.extract! @event, :id, :title, :description, :all_day, :created_at, :created_at
json.start @event.start_time
json.end @event.end_time
if @event.user
  json.user do
    json.id @event.user.id
    json.nome @event.user.funcionario.nome
  end
end
if @event.cliente
  json.cliente do
    json.id @event.cliente.id
    json.nome @event.cliente.nome
  end
end
