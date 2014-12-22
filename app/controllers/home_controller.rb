class HomeController < ApplicationController
  def index
    @courses = Course.includes(:skills).featured
  end
end
