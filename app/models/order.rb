# frozen_string_literal: true

# == Schema Information
#
# Table name: orders
#
#  id              :bigint           not null, primary key
#  delivery_fee    :string
#  dt_order_create :string
#  external_code   :string
#  number          :string
#  postal_code     :string
#  sub_total       :string
#  total           :string
#  total_shipping  :float
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  store_id        :integer
#
class Order < ApplicationRecord
  has_one :customer
  has_one :address

  has_many :items
  has_many :payments

  accepts_nested_attributes_for :customer
  validates_associated :customer

  accepts_nested_attributes_for :address
  validates_associated :address

  accepts_nested_attributes_for :items
  validates_associated :items

  accepts_nested_attributes_for :payments
  validates_associated :payments

  validates :external_code,
            :store_id,
            :sub_total,
            :delivery_fee,
            :total,
            :dt_order_create,
            :postal_code,
            :number, presence: true
end
