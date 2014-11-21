module ::Concerns::Course::Validations
  extend ActiveSupport::Concern

  included do
    validates_presence_of :title, :abbrev, :creator

    validates_uniqueness_of :title,  scope: :creator_id
    validates_uniqueness_of :abbrev, scope: :creator_id
  end
end