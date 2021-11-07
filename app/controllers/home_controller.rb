class HomeController < ApplicationController
  def index
    @univs = University.all
    @faculties = Faculty.all
  end
end
