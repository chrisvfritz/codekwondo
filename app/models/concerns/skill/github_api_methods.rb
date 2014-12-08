module ::Concerns::Skill::GithubApiMethods
  extend ActiveSupport::Concern

  # ---------
  # CALLBACKS
  # ---------

  included do
    after_save :update_gist
  end

  def update_gist
    return create_gist if self.gist_id.blank?

    self.creator.github_api.gists.edit(
      self.gist_id,
      files: files_for_gist
    )
  rescue
    false
  end

  def create_gist
    gist = self.creator.github_api.gists.create(
      description: self.title,
      public: false,
      files: files_for_gist
    )

    self.update_columns(gist_id: gist.id)
  rescue
    false
  end

  # --------------
  # SHARED METHODS
  # --------------

  def files_for_gist
    {
      "presentation.md" => {
        content: self.presentation
      }
    }
  end

  # ------------------
  # VIRTUAL ATTRIBUTES
  # ------------------

  def gist_url
    create_gist if self.gist_id.blank?
    "https://gist.github.com/#{self.gist_id}"
  end

end