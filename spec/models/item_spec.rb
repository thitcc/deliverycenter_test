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
require "rails_helper"

RSpec.describe Item, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:order) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:external_code) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_presence_of(:quantity) }
    it { is_expected.to validate_presence_of(:total) }
  end
end
