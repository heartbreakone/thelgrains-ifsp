json.array!(@admin_web_comentarios) do |admin_web_comentario|
  json.extract! admin_web_comentario, :id
  json.url admin_web_comentario_url(admin_web_comentario, format: :json)
end
