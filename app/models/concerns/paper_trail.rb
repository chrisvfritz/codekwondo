module PaperTrail
  extend ActiveSupport::Concern

  included do
    has_paper_trail
  end

  def maintainer_id
    versions.last.whodunnit == user.id
  end
end