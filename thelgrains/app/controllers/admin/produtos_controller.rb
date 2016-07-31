module Admin

  ##
  # Controlador do CRUD de Produtos.
  class ProdutosController < ApplicationController
    include Administrable
    before_action :set_produto, only: [:show, :edit, :update, :destroy]

    # GET /admin/produtos
    # GET /admin/produtos.json
    def index
      @produtos = Produto.all
    end

    # GET /admin/produtos/1
    # GET /admin/produtos/1.json
    def show
    end

    # GET /admin/produtos/new
    def new
      @produto = Produto.new
    end

    # GET /admin/produtos/1/edit
    def edit
    end

    # POST /admin/produtos
    # POST /admin/produtos.json
    def create
      @produto = Produto.new(produto_params)

      respond_to do |format|
        if @produto.save
          format.html { redirect_to @produto, notice: 'Produto was successfully created.' }
          format.json { render :show, status: :created, location: @produto }
        else
          format.html { render :new }
          format.json { render json: @produto.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /admin/produtos/1
    # PATCH/PUT /admin/produtos/1.json
    def update
      respond_to do |format|
        if @produto.update(produto_params)
          format.html { redirect_to @produto, notice: 'Produto was successfully updated.' }
          format.json { render :show, status: :ok, location: @produto }
        else
          format.html { render :edit }
          format.json { render json: @produto.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /admin/produtos/1
    # DELETE /admin/produtos/1.json
    def destroy
      @produto.destroy
      respond_to do |format|
        format.html { redirect_to admin_produtos_url, notice: 'Produto was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_produto
        @produto = Produto.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def produto_params
        params[:produto]
      end
  end
end
