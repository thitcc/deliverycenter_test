# frozen_string_literal: true

# == Schema Information
#
# Table name: payments
#
#  id         :bigint           not null, primary key
#  modality   :string
#  value      :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  order_id   :bigint           not null
#
# Indexes
#
#  index_payments_on_order_id  (order_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_id => orders.id)
#
class Payment < ApplicationRecord
  belongs_to :order

  alias_attribute :type, :modality

  validates :modality, :value, presence: true
end
