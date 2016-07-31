##
# Módulo que permite os requests em XHR.
module XhrRequestable
  extend ActiveSupport::Concern

  included do
    skip_before_action :verify_authenticity_token
    respond_to :json
  end

end
