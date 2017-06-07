class RemoveBillingProvince < ActiveRecord::Migration[5.0]
  def change
    remove_column :orders, :billing_province
    remove_column :orders, :billing_city
    remove_column :orders, :billing_district
  end
end
