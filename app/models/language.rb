class Language < ActiveRecord::Base
  has_many :skills, foreign_key: 'primary_language_id'
end
