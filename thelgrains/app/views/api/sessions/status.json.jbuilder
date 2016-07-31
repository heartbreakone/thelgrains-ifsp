json.status do
  # json.exists (User.find_by_cpf(params[:api_user][:cpf]) ? true : false) if params[:api_user]
  json.success api_user_signed_in?
  # TODO
  if session[:just_sign_in]
    # json.token current_api_user.authentication_token
    # session[:just_sign_in] = false
  end
  json.error flash[:error] if flash[:error]
  json.notice flash[:notice] if flash[:notice]
  json.alert flash[:alert] if flash[:alert]
end
if api_user_signed_in?
  json.user do
    json.id current_api_user.id
    json.active current_api_user.active
    json.nome current_api_user.nome
  end
end
