# frozen_string_literal: true

class Api::V2::BaseController < ApplicationController
  include ExceptionHandler

  before_action :authenticate

  def authenticate
    url = ENV['API_URL'] + '/auth/get_token'

    response = HTTParty.get(url)
  
    @token = response['token']
  end
end
