module Repositories
  class Create < ActiveInteraction::Base
    object :user, class: User
    string :technology_name
    string :category_name
    string :repository_name

    def execute
      ApplicationRecord.transaction do
        technology = user.technologies.find_or_create_by(name: technology_name.presence)

        if technology.new_record?
          errors.merge!(technology.errors)

          raise ActiveRecord::Rollback
        end

        category = technology.categories.find_or_create_by(name: category_name.presence)

        if category.new_record?
          errors.merge!(category.errors)

          raise ActiveRecord::Rollback
        end

        repository = category.repositories.find_or_create_by(name: repository_name.presence)

        if repository.new_record?
          errors.merge!(repository.errors)

          raise ActiveRecord::Rollback
        end
        # TODO: GitHub GraphQL fetch
        # if success update repository
        # if failed return error
      end
    end
  end
end

