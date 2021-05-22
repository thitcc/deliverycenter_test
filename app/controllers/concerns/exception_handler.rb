module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError do |error|
      render status: :not_found
    end
  end
end 