# frozen_string_literal: true

class Api::V1::BaseController < ApplicationController
  rescue_from StandardError do |error|
    render status: :not_found
  end
end