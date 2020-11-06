class TechnologiesController < ApplicationController
  def index
    @technologies = current_user.technologies
  end
end
