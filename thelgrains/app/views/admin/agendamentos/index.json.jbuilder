json.array!(@agendamentos) do |admin_agendamento|
  json.extract! admin_agendamento, :id
  json.url admin_agendamento_url(admin_agendamento, format: :json)
end
