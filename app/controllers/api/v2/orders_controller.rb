# frozen_string_literal: true

class Api::V2::OrdersController < Api::V2::BaseController
  before_action :create_order

  def create
    @builder = payload_to_camel_case

    if order_params.blank?
      render status: :not_found
    end

    if ProcessOrderService.call(@builder, @token)
      render status: :accepted
    else
      render status: :not_found
    end
  end

  private

  def create_order
    @payload = OrderPayloadService.call(order_params)

    attributes = @payload
    attributes[:items_attributes].map! { |hash| hash&.except!('sub_items') }

    @order = Order.create!(attributes)
  end

  def payload_to_camel_case
    camel_case_payload.merge!({ total_shipping: total_shipping }).to_json
  end

  def camel_case_payload
    @payload.deep_transform_keys! do |key|
      key.to_s.gsub("attributes", "").camelize(:lower)
    end
  end

  def total_shipping
    order_params["total_shipping"] || 0.0
  end

  def order_params
    params.permit(
      :id, 
      :store_id, 
      :date_created, 
      :date_closed, 
      :last_updated, 
      :total_amount, 
      :total_shipping, 
      :total_amount_with_shipping, 
      :paid_amount,
      :expiration_date,
      :status,
      order_items: [
        {
          item: [
            :id, 
            :title
          ]
        }, 
        :quantity, 
        :unit_price, 
        :full_unit_price
      ],
      payments: [
        :id, 
        :order_id, 
        :payer_id, 
        :installments, 
        :payment_type, 
        :status, 
        :transaction_amount, 
        :taxes_amount, 
        :shipping_cost, 
        :total_paid_amount, 
        :installment_amount, 
        :date_approved, 
        :date_created
      ],
      shipping: [
        :id,
        :shipment_type,
        :date_created,
        {
          receiver_address: [
            :id,
            :address_line,
            :street_name,
            :street_number,
            :comment,
            :zip_code,
            {
              city: [
                :name
              ]
            },
            {
              state: [
                :id,
                :name
              ]
            },
            {
              country: [
                :id,
                :name
              ]
            },
            {
              neighborhood: [
                :id,
                :name
              ]
            },
            :latitude,
            :longitude,
            :receiver_phone 
          ]
        }
      ],
      buyer: [
        :id,
        :nickname,
        :email,
        {
          phone: [
            :area_code,
            :number
          ]
        },
        :first_name,
        :last_name,
        {
          billing_info: [
            :doc_type,
            :doc_number
          ]
        }
      ]
    )
  end
end
