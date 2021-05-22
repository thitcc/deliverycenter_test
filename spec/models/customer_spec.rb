# frozen_string_literal: true

# == Schema Information
#
# Table name: customers
#
#  id          :bigint           not null, primary key
#  contact     :string
#  email       :string
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  external_id :string
#  order_id    :bigint           not null
#
# Indexes
#
#  index_customers_on_order_id  (order_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_id => orders.id)
#
require "rails_helper"

RSpec.describe Customer, type: :model do
  describe 'associations' do
    it { should belong_to(:order) }
  end

  describe 'validations' do
    [:external_id, :name, :email, :contact].each { |attribute| it { should validate_presence_of(attribute) } }
  end
end
