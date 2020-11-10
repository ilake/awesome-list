class RepositoriesController < ApplicationController
  def index
    @repositories = Repository.
      joins(categories: :technology).
      where(categories: {
              name: params[:category_name],
              technologies: {
                name: params[:technology_name],
                user_id: current_user.id
              }
            })
  end

  def show
    @repository = Repository.
      joins(categories: :technology).
      where(name: params[:repository_name],
            categories: {
              name: params[:category_name],
              technologies: {
                name: params[:technology_name],
                user_id: current_user.id
              }
            }).take
  end

  def new
    @outcome = Repositories::Create.new
  end

  def create
    @outcome = Repositories::Create.run(
      user: current_user,
      technology_name: params[:repositories_create][:technology_name],
      category_name: params[:repositories_create][:category_name],
      repository_name: params[:repositories_create][:repository_name]
    )

    if @outcome.valid?
      redirect_to root_path
    else
      render :new
    end
  end
end
