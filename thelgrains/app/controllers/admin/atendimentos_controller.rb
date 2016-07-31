module Admin

  ##
  # Controlador do CRUD de Atendimentos
  class AtendimentosController < ApplicationController
    include Administrable
    before_action :set_atendimento, only: [:show, :edit, :update, :destroy]

    # GET /admin/atendimentos
    # GET /admin/atendimentos.json
    def index
      @atendimentos = Atendimento.all
    end

    # GET /admin/atendimentos/1
    # GET /admin/atendimentos/1.json
    def show
    end

    # GET /admin/atendimentos/new
    def new
      @atendimento = Atendimento.new
    end

    # GET /admin/atendimentos/1/edit
    def edit
    end

    # POST /admin/atendimentos
    # POST /admin/atendimentos.json
    def create
      @atendimento = Atendimento.new(atendimento_params)

      respond_to do |format|
        if @atendimento.save
          format.html { redirect_to @atendimento, notice: 'Atendimento was successfully created.' }
          format.json { render :show, status: :created, location: @atendimento }
        else
          format.html { render :new }
          format.json { render json: @atendimento.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /admin/atendimentos/1
    # PATCH/PUT /admin/atendimentos/1.json
    def update
      respond_to do |format|
        if @atendimento.update(atendimento_params)
          format.html { redirect_to @atendimento, notice: 'Atendimento was successfully updated.' }
          format.json { render :show, status: :ok, location: @atendimento }
        else
          format.html { render :edit }
          format.json { render json: @atendimento.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /admin/atendimentos/1
    # DELETE /admin/atendimentos/1.json
    def destroy
      @atendimento.destroy
      respond_to do |format|
        format.html { redirect_to atendimentos_url, notice: 'Atendimento was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_atendimento
      @atendimento = Atendimento.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def atendimento_params
      params[:atendimento]
    end
  end
end
