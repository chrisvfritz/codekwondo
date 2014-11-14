class Skill < ActiveRecord::Base
  include ::Concerns::Skill::DagMethods
  include PaperTrail
  include ::Concerns::Skill::Validations

  belongs_to :course
  belongs_to :primary_language, class_name: 'Language'
  belongs_to :creator, class_name: 'User'

  has_many :skill_relationships, dependent: :destroy
  has_many :prereqs, through: :skill_relationships

  has_many :inverse_skill_relationships, class_name: 'SkillRelationship', foreign_key: 'prereq_id', dependent: :destroy
  has_many :inverse_prereqs, through: :inverse_skill_relationships, source: :skill

  has_many :resources
  has_many :projects
  has_one  :teaching_material

  acts_as_list scope: :course

  def stack_overflow_questions
    escaped_title = URI.encode_www_form_component(title)
    response = RestClient.get("https://stackoverflow.com/search/titles?title=#{escaped_title}")
    json_response = ActiveSupport::JSON.decode(response)
    json_response['content'].gsub('href="/', 'href="https://stackoverflow.com/')
  end
end
