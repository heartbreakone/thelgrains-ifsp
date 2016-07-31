module Api
  class ServicosController < ApplicationController
  include Apiable

    def index
      @categorias = CategoriaServico.all
    end
  end
end
