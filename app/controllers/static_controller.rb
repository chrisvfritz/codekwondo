class StaticController < ApplicationController
  def home
    @instructors = User.instructors.includes(created_courses: :creator)
  end
end
