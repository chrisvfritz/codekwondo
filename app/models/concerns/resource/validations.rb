module Resource::Validations
  extend ActiveSupport::Concern

  included do
    validates_presence_of :title, :url, :skill
  end
end