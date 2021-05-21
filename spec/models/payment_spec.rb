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
require "rails_helper"

RSpec.describe Payment, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:order) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:modality) }
    it { is_expected.to validate_presence_of(:value) }
  end
end
