class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.integer :title
      t.integer :resource

      t.timestamps
    end
  end
end
