module Admin

  ##
  # Controlador do CRUD de Funcionarios
  class FuncionariosController < ApplicationController
    include Administrable
    before_action :set_funcionario, only: [:show, :edit, :update, :destroy]

    # GET /admin/funcionarios
    # GET /admin/funcionarios.json
    def index
      @funcionarios = Funcionario.page(params[:page] || 1)
    end

    # GET /admin/funcionarios/1
    # GET /admin/funcionarios/1.json
    def show
      @n_atendimentos = Atendimento.where(user: @funcionario.user).count
      @n_agendamentos = Agendamento.where(user: @funcionario.user).count
    end

    # GET /admin/funcionarios/new
    def new
      @funcionario = Funcionario.new
      @funcionario.build_user
    end

    # GET /admin/funcionarios/1/edit
    def edit
    end

    # POST /admin/funcionarios
    # POST /admin/funcionarios.json
    def create
      @funcionario = Funcionario.new(funcionario_params)
      @funcionario.build_user(user_params)
      @funcionario.endereco = Funcionario.concat_endereco endereco_params
      if @funcionario.save
        redirect_to admin_funcionarios_path, notice: 'Funcionário foi criado!.'
      else
        render :new
      end
    end

    # PATCH/PUT /admin/funcionarios/1
    # PATCH/PUT /admin/funcionarios/1.json
    def update
      respond_to do |format|
        @funcionario.user.attributes = remove_blank(user_params)
        if @funcionario.update! remove_blank(funcionario_params)
          format.html { redirect_to admin_funcionario_path(@funcionario), notice: 'Funcionário foi atualizado.' }
          format.json { render :show, status: :ok, location: @funcionario }
        else
          format.html { render :edit }
          format.json { render json: @funcionario.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /admin/funcionarios/1
    # DELETE /admin/funcionarios/1.json
    def destroy
      @funcionario.destroy
      respond_to do |format|
        format.html { redirect_to admin_funcionarios_url, notice: 'Funcionário foi deletado!' }
        format.json { head :no_content }
      end
    end

    private

    ##
    # Remove atributos em branco
    def remove_blank(attributes)
      attributes.keep_if { |k, v| not v.blank? }
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_funcionario
      @funcionario = Funcionario.find(params[:id]) || Funcionario.find_by_cpf(params[:cpf])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def funcionario_params
      params.require(:funcionario).permit(:id, :nome, :telefone, :celular, :cep, :email, :sexo, :nascimento)
    end

    # parâmetros do endereço
    def endereco_params
      params.require(:funcionario).permit(endereco: [:logradouro, :numero, :complemento, :bairro, :cidade, :estado])
    end

    # parâmetros do user
    def user_params
      params.require(:user).permit(:id, :cpf, :password, :password_confirmation, :admin, admin: [])
    end
  end
end
