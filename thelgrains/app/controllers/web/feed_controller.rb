module Web

  ##
  # Controlador de agendamentos para o FullCalendar
  class FeedController < EventsController
    include Webable
    skip_before_action :require_login

    def funcionarios
      funcionarios = Funcionario.all
      render json: funcionarios
    end

  end
end
