class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.integer :course_id
      t.string :name

      t.timestamps
    end

    add_index :sections, [:course_id, :name], unique: true
  end
end
