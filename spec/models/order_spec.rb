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
require "rails_helper"

RSpec.describe Order, type: :model do
  describe "associations" do
    [:customer, :address].each { |attribute| it { should have_one(attribute) } }

    [:items, :payments].each { |attribute| it { should have_many(attribute) } }

    [:customer, :items, :payments].each { |attribute| it { should accept_nested_attributes_for(attribute) } }
  end

  describe "validations" do
    [:external_code, 
      :store_id, 
      :sub_total, 
      :delivery_fee, 
      :total,
      :dt_order_create, 
      :postal_code, 
      :number].each { |attribute| it { should validate_presence_of(attribute) } }
  end
end
