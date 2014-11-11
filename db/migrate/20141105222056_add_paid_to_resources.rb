class AddPaidToResources < ActiveRecord::Migration
  def change
    add_column :resources, :paid,  :boolean
    add_column :resources, :price, :decimal, precision: 8, scale: 2
  end
end
