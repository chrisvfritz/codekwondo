class AddAbbrevToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :abbrev, :string
  end
end
