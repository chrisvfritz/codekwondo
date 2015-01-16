class CreateEnrollments < ActiveRecord::Migration
  def change
    create_table :enrollments do |t|
      t.string :first_name
      t.string :last_name
      t.string :preferred_name
      t.integer :section_id
      t.integer :user_id

      t.timestamps
    end

    add_index :enrollments, [:section_id, :user_id], unique: true
    add_index :enrollments, [:first_name, :last_name, :section_id], unique: true
  end
end
