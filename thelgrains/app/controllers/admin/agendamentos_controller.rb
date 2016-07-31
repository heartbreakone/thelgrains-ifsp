##
# Namespace para área de administração.
module Admin

  ##
  # Controlador do CRUD de Agendamentos.
  class AgendamentosController < ApplicationController
    include Administrable
    before_action :set_agendamento, only: [:show, :edit, :update, :destroy]

    # GET /admin/agendamentos
    # GET /admin/agendamentos.json
    def index
      @agendamentos = Agendamento.page(params[:page]).per 10
    end

    # GET /admin/agendamentos/1
    # GET /admin/agendamentos/1.json
    def show
    end

    # GET /admin/agendamentos/new
    def new
      @agendamento = Agendamento.new
      @funcionarios = [['Selecione', nil]]
      User.all.each do |u| @funcionarios.push [u.funcionario.nome, u.id] end
      @clientes = [['Selecione', -1], ['Não cadastrado', nil]]
      Cliente.all.each do |c| @clientes.push [c.nome, c.id] end
    end

    # GET /admin/agendamentos/1/edit
    def edit
    end

    # POST /admin/agendamentos
    # POST /admin/agendamentos.json
    def create
      @agendamento = Agendamento.new(agendamento_params)
      if @agendamento.valid?
        num = agendamento_params.end_time
        params[:agendamento][:end_time] = agendamento_params.start_time + num.hours
      end

      respond_to do |format|
        if @agendamento.save
          format.html { redirect_to @agendamento, notice: 'Agendamento was successfully created.' }
          format.json { render :show, status: :created, location: @agendamento }
        else
          format.html { render :new }
          format.json { render json: @agendamento.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /admin/agendamentos/1
    # PATCH/PUT /admin/agendamentos/1.json
    def update
      respond_to do |format|
        if @agendamento.update(agendamento_params)
          format.html { redirect_to @agendamento, notice: 'Agendamento was successfully updated.' }
          format.json { render :show, status: :ok, location: @agendamento }
        else
          format.html { render :edit }
          format.json { render json: @agendamento.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /admin/agendamentos/1
    # DELETE /admin/agendamentos/1.json
    def destroy
      @agendamento.destroy
      respond_to do |format|
        format.html { redirect_to agendamentos_url, notice: 'Agendamento was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_agendamento
        @agendamento = Agendamento.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def agendamento_params
        params.require(:agendamento).permit(:title, :description, :start_time, :end_time, :cliente_id, :funcionario_id)
      end
  end
end
