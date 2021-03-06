class Skill < ActiveRecord::Base
  include ::Concerns::Skill::DagMethods
  include ::Concerns::PaperTrail
  include ::Concerns::Skill::Validations
  include ::Concerns::Skill::GithubApiMethods

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

  acts_as_taggable

  acts_as_list scope: :course

  def related_stackoverflow_questions
    Rails.cache.fetch("related_stackoverflow_questions: {skill_id: #{self.title}, tags: #{self.tag_list}, version: 6}", expires_in: 1.day) do
      Array(
        RubyStackoverflow.similar(
          self.title,
          {
            tagged: self.tag_list.join(';'),
            pagesize: 10,
            sort: 'relevance',
            order: 'desc'
          }
        ).data
      ).map do |question|
        OpenStruct.new(JSON.parse(question.to_json))
      end
    end
  end

end
