module Course::Validations
  extend ActiveSupport::Concern

  included do
    validates_presence_of :title, :abbrev
  end
end