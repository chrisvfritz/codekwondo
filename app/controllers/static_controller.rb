class StaticController < ApplicationController
  def home
    @courses = Course.featured
  end
end
