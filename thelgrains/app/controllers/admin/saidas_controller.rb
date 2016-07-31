module Admin

  ##
  # Controlador de CRUD das Saídas.
  class SaidasController < ApplicationController
    before_action :set_admin_saida, only: [:show, :edit, :update, :destroy]

    # GET /admin/saidas
    # GET /admin/saidas.json
    def index
      @admin_saidas = Saida.all
    end

    # GET /admin/saidas/1
    # GET /admin/saidas/1.json
    def show
    end

    # GET /admin/saidas/new
    def new
      @admin_saida = Saida.new
    end

    # GET /admin/saidas/1/edit
    def edit
    end

    # POST /admin/saidas
    # POST /admin/saidas.json
    def create
      @admin_saida = Saida.new(admin_saida_params)

      respond_to do |format|
        if @admin_saida.save
          format.html { redirect_to @admin_saida, notice: 'Saida was successfully created.' }
          format.json { render :show, status: :created, location: @admin_saida }
        else
          format.html { render :new }
          format.json { render json: @admin_saida.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /admin/saidas/1
    # PATCH/PUT /admin/saidas/1.json
    def update
      respond_to do |format|
        if @admin_saida.update(admin_saida_params)
          format.html { redirect_to @admin_saida, notice: 'Saida was successfully updated.' }
          format.json { render :show, status: :ok, location: @admin_saida }
        else
          format.html { render :edit }
          format.json { render json: @admin_saida.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /admin/saidas/1
    # DELETE /admin/saidas/1.json
    def destroy
      @admin_saida.destroy
      respond_to do |format|
        format.html { redirect_to admin_saidas_url, notice: 'Saida was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_admin_saida
        @admin_saida = Saida.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def admin_saida_params
        params.require(:admin_saida).permit(:descricao, :valor)
      end
  end
end
