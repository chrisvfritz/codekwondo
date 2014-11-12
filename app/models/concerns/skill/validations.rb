module ::Concerns::Skill::Validations
  extend ActiveSupport::Concern

  included do
    validates_presence_of :title, :primary_language
  end
end