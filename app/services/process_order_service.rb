# frozen_string_literal: true

class ProcessOrderService < BaseService
  def call payload, token
    url = ENV['API_URL'] + '/api/v2/order'
    
    response = HTTParty.post(url, { body:  payload, headers: { 'Authorization' => "#{token}", 'X-Sent' => "#{Time.zone.now.strftime("%Hh%M - %d/%m/%y")}" } } )

    response.code == 200
  end
end
