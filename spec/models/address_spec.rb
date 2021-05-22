# == Schema Information
#
# Table name: addresses
#
#  id         :bigint           not null, primary key
#  city       :string
#  complement :string
#  country    :string
#  district   :string
#  latitude   :decimal(10, 6)
#  longitude  :decimal(10, 6)
#  state      :string
#  street     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  order_id   :bigint           not null
#
# Indexes
#
#  index_addresses_on_order_id  (order_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_id => orders.id)
#
require "rails_helper"

RSpec.describe Address, type: :model do
  describe 'associations' do
    it { should belong_to(:order) }
  end

  describe 'validations' do
    [:city, :country, :district, :state, :street, :latitude, :longitude].each { |attribute| it { should validate_presence_of(attribute) } }
  end
end
