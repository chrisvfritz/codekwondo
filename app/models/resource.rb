class Resource < ActiveRecord::Base
  belongs_to :creator, class_name: 'User'
  belongs_to :skill

  include ::Concerns::Resource::Validations
  include UrlValidations
  include ::Concerns::Resource::RatingSystem
  include PaperTrail
end
