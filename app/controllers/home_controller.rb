class HomeController < ApplicationController
  def index
    @courses = Course.includes(:creator, :skills).featured
  end
end
