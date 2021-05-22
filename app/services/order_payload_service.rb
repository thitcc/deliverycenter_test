# frozen_string_literal: true

class OrderPayloadService < BaseService
  def call(params)
    @order_params = params

    {
      external_code: @order_params["id"].to_s,
      store_id: @order_params["store_id"],
      sub_total: sub_total,
      delivery_fee: @order_params["total_shipping"].to_s,
      total: @order_params["total_amount_with_shipping"].to_s,
      dt_order_create: @order_params["date_created"],
      postal_code: @order_params["shipping"]["receiver_address"]["zip_code"],
      number: @order_params["shipping"]["receiver_address"]["street_number"],
      address_attributes: address_block,
      customer_attributes: customer_block,
      items_attributes: items_block,
      payments_attributes: payments_block
    }
  rescue
    {}
  end

  private

  def address_block
    address = @order_params["shipping"]["receiver_address"]

    {
      "country" => country,
      "state" => address["state"]["id"],
      "city" => address["city"]["name"],
      "district" => address["neighborhood"]["name"],
      "street" => address["street_name"],
      "complement" => address["comment"],
      "latitude" => address["latitude"],
      "longitude" => address["longitude"]
    }
  end

  def customer_block
    buyer = @order_params["buyer"]
    buyer_phone = @order_params["buyer"]["phone"]

    {
      "external_code" => buyer["id"].to_s,
      "name" => buyer["nickname"].to_s,
      "email" => buyer["email"].to_s,
      "contact" => "#{buyer_phone["area_code"]}#{buyer_phone["number"]}"
    }
  end

  def items_block
    @order_params["order_items"].map do |item|
      {
        "external_code" => item["item"]["id"],
        "name" => item["item"]["title"],
        "price" => item["full_unit_price"],
        "quantity" => item["quantity"],
        "total" => item["unit_price"].to_f * item["quantity"].to_i,
        "sub_items" => []
      }
    end
  rescue NoMethodError
    []
  end

  def payments_block
    @order_params["payments"].map do |payment|
      {
        "type" => payment["payment_type"].upcase,
        "value" => payment["total_paid_amount"]
      }
    end
  rescue NoMethodError
    []
  end
  
  def sub_total
    format("%<total>.2f", total: @order_params["total_amount"])
  rescue
    0.0
  end

  def country
    @order_params["shipping"]["receiver_address"]["country"]["id"]
  rescue
    "BR"
  end
end