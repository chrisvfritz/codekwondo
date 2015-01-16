class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.integer :section_id
      t.datetime :start_time
      t.datetime :end_time
      t.hstore :attendence, default: '', null: false

      t.timestamps
    end

    add_index :sessions, [:section_id, :start_time], unique: true
  end
end
