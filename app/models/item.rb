# frozen_string_literal: true

# == Schema Information
#
# Table name: items
#
#  id            :bigint           not null, primary key
#  external_code :string
#  name          :string
#  price         :float
#  quantity      :integer
#  total         :float
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  order_id      :bigint           not null
#
# Indexes
#
#  index_items_on_order_id  (order_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_id => orders.id)
#
class Item < ApplicationRecord
  belongs_to :order

  validates :external_code, :name, :price, :quantity, :total, presence: true
end
