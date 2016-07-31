Rails.application.routes.draw do

  post 'comentario', to: 'web_comentarios#create'

  namespace 'api' do
    devise_for :users, path: '', controllers: { sessions: 'api/sessions' },
                       path_names: { sign_in: 'login', sign_out: 'logout' },
                       sign_out_via: :delete
    get 'atendimentos', to: 'atendimentos#index'
    post 'atendimentos', to: 'atendimentos#create'
    get 'clientes', to: 'clientes#index'
    get 'servicos', to: 'servicos#index'
    get 'funcionarios', to: 'funcionarios#index'
  end

  namespace 'admin' do
    # login e logout
    devise_for :users, path: '', controllers: { sessions: 'admin/sessions' },
                       path_names: { sign_in: 'login', sign_out: 'logout' },
                       sign_out_via: [:delete, :get, :post]

    root to: redirect('admin/dashboard')
    # pagina inicial (redirect para login se não autenticado)
    authenticate :admin_user do
      get 'dashboard', to: 'app#dashboard'
    end
    # outras paginas (404 se não autenticado)
    authenticate :admin_user do
      get 'contabilidade', to: 'app#contabilidade'

      resources :clientes, :agendamentos, :produtos, :web_comentarios
      resources :atendimentos # TODO, ajudantes
      resources :servicos # TODO, rever rotas (GET edit e new via AJAX)(neasted)
      post 'servicos/categoria', to: 'servicos#create_categoria'
      resources :funcionarios
    end
  end

  scope module: 'web' do
    post 'login', to: 'sessions#create'
    get 'login', to: 'sessions#new'
    get 'logout', to: 'sessions#destroy'
    get 'home', to: 'app#index'
    resources :caixa, only: [:index, :show, :update]
    resources :atendimentos, :agendamentos
    resources :feed, except: [:edit, :new]
  end

end
