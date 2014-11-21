module ::Concerns::Skill::Validations
  extend ActiveSupport::Concern

  included do
    validates_presence_of :title, :primary_language, :course, :creator

    validates_uniqueness_of :title, scope: :course_id
  end
end