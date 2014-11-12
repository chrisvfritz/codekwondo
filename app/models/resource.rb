class Resource < ActiveRecord::Base
  belongs_to :skill

  include Resource::Validations
  include UrlValidations
  include Resource::RatingSystem
  include PaperTrail
end
