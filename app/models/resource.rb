class Resource < ActiveRecord::Base
  belongs_to :skill

  include Validations
  include UrlValidations
  include RatingSystem
  include PaperTrail
end
