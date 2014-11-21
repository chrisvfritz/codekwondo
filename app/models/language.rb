class Language < ActiveRecord::Base
  has_many :skills, foreign_key: 'primary_language_id'

  validates_presence_of   :name, :abbrev
  validates_uniqueness_of :name, :abbrev
end
