class CategoriesController < ApplicationController
  def index
    @categories = Category.joins(:technology).where(technologies: { name: params[:technology_name], user_id: current_user.id })
  end
end
