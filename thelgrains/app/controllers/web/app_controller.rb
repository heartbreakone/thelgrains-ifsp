##
# Módulo dos controladores da interface web de login único.
module Web

  ##
  # Controlador da página index da interface web.
  class AppController < ApplicationController
    include Webable

    # GET em /app
    def index
    end

  end
end
