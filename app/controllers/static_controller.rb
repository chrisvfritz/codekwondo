class StaticController < ApplicationController
  def home
    @courses = Course.includes(:creator, :skills).featured
  end
end
