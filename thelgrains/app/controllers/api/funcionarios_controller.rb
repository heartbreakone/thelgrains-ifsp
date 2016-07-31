module Api
  class FuncionariosController < ApplicationController

    def index
      @funcionarios = Funcionario.all
    end
  end
end
