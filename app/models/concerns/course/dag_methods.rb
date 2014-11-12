module ::Concerns::Course::DagMethods
  extend ActiveSupport::Concern

  def dag_label
    abbrev.to_s
  end

  def dag_class
    'course'
  end
end