module ::Concerns::Resource::Validations
  extend ActiveSupport::Concern

  included do
    validates_presence_of :title, :url, :skill, :creator

    validates_uniqueness_of :title, scope: :skill_id
    validates_uniqueness_of :url,   scope: :skill_id
  end
end