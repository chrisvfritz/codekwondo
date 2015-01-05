module ::Concerns::Skill::DagMethods
  extend ActiveSupport::Concern

  def dag_label
    position.to_s + ':' + primary_language.abbrev
  end

  def dag_class
    [
      primary_language.abbrev.downcase
    ].join ' '
  end
end