module Admin

  ##
  # Controlador do CRUD de Serviços e Categorias
  class ServicosController < ApplicationController
    include Administrable
    before_action :set_servico, only: [:show, :edit, :update, :destroy]
    before_action :load_categorias, only: [:new, :edit, :index]

    # GET /admin/servicos
    # GET /admin/servicos.json
    def index
      @servicos = Servico.all
      @categoria_servicos = [['Todos', 'all']]
      CategoriaServico.all.each { |c| @categoria_servicos.push [c.nome, c.id] }
    end

    # GET /admin/servicos/1
    # GET /admin/servicos/1.json
    def show
    end

    # GET /admin/servicos/1/edit
    def edit
    end

    def new
      @servico = Servico.new
      @categoria_servico = CategoriaServico.new
    end

    # POST /admin/servicos
    # POST /admin/servicos.json
    def create
      @servico = Servico.new(servico_params)
      respond_to do |format|
        if @servico.save
          format.html { redirect_to '/admin/servicos', notice: 'Servico was successfully created.' }
          format.json { render :show, status: :created, location: @servico }
        else
          format.html { render :new }
          format.json { render json: @servico.errors, status: :unprocessable_entity }
        end
      end
    end

    def create_categoria
      @categoria_servico = CategoriaServico.new(categoria_params)
      respond_to do |format|
        if @categoria_servico.save
          format.html { redirect_to '/admin/servicos', notice: 'Servico was successfully created.' }
          format.json { render :show, status: :created, location: @servico }
        else
          format.html { redirect_to '/admin/servicos/new' }
          format.json { render json: @categoria_servico.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /admin/servicos/1
    # PATCH/PUT /admin/servicos/1.json
    def update
      respond_to do |format|
        if @servico.update(servico_params)
          format.html { redirect_to @servico, notice: 'Servico was successfully updated.' }
          format.json { render :show, status: :ok, location: @servico }
        else
          format.html { render :edit }
          format.json { render json: @servico.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /admin/servicos/1
    # DELETE /admin/servicos/1.json
    def destroy
      @servico.destroy
      respond_to do |format|
        format.html { redirect_to admin_servicos_url, notice: 'Servico was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_servico
      @servico = Servico.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def servico_params
      params.require(:servico).permit(:nome, :valor, :categoria_servico_id, :taxa)
    end

    def categoria_params
      params.permit(:nome)
    end

    def load_categorias
      @categoria_servicos = [['Selecione', nil]]
      CategoriaServico.all.each do |c| @categoria_servicos.push [c.nome, c.id] end
    end

  end
end
