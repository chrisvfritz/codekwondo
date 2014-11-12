class Resource < ActiveRecord::Base
  belongs_to :skill

  include ::Concerns::Resource::Validations
  include UrlValidations
  include ::Concerns::Resource::RatingSystem
  include PaperTrail
end
