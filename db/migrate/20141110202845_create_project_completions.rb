class CreateProjectCompletions < ActiveRecord::Migration
  def change
    create_table :project_completions do |t|
      t.integer :project_id
      t.integer :user_id
      t.string :url
      t.hstore :criteria_completion, default: '', null: false

      t.timestamps
    end
  end
end
