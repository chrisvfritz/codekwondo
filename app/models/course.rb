class Course < ActiveRecord::Base
  include DagMethods
  include PaperTrail

  has_many :skills

  has_many :course_relationships, dependent: :destroy
  has_many :prereqs, through: :course_relationships

  has_many :inverse_course_relationships, class_name: 'CourseRelationship', foreign_key: 'prereq_id', dependent: :destroy
  has_many :inverse_prereqs, through: :inverse_course_relationships, source: :course

  acts_as_list

  def language_breakdown
    return [] if skills.none?

    skills.includes(:primary_language).map{|s| s.primary_language.abbrev}.inject(Hash.new(0)) { |h, e| h[e] += 1 ; h }.to_a.map{|a| {label: a[0], value: a[1]}}
  end
end
