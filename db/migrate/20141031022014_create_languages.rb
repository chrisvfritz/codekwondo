class CreateLanguages < ActiveRecord::Migration
  def change
    create_table :languages do |t|
      t.string :name
      t.string :abbrev

      t.timestamps
    end

    Language.new( name: 'HTML',       abbrev: 'HTML' ).save
    Language.new( name: 'CSS',        abbrev: 'CSS'  ).save
    Language.new( name: 'JavaScript', abbrev: 'JS'   ).save
    Language.new( name: 'Ruby',       abbrev: 'RB'   ).save
  end
end
