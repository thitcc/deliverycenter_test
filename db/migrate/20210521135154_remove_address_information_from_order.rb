class RemoveAddressInformationFromOrder < ActiveRecord::Migration[6.0]
  def up
    remove_columns :orders, :country, :state, :city, :district, :street, :latitude, :longitude, :complement
  end

  def down
    add_column :orders, :country, :string
    add_column :orders, :state, :string
    add_column :orders, :city, :string
    add_column :orders, :district, :string
    add_column :orders, :street, :string
    add_column :orders, :latitude, :decimal, precision: 10, scale: 6
    add_column :orders, :longitude, :decimal, precision: 10, scale: 6
    add_column :orders, :complement, :string
  end
end
