require "github/repository_query"

module Repositories
  class Create < ActiveInteraction::Base
    object :user, class: User
    string :technology_name
    string :category_name
    string :repository_name

    validates :technology_name, presence: true
    validates :category_name, presence: true
    validate :validate_repository_name

    def execute
      ApplicationRecord.transaction do
        technology = user.technologies.find_or_create_by(name: technology_name)

        if technology.new_record?
          errors.merge!(technology.errors)

          raise ActiveRecord::Rollback
        end

        category = technology.categories.find_or_create_by(name: category_name)

        if category.new_record?
          errors.merge!(category.errors)

          raise ActiveRecord::Rollback
        end

        owner, name = repository_name.split("/")
        repository = category.repositories.find_or_create_by(name: name.presence)

        if repository.new_record?
          errors.merge!(repository.errors)

          raise ActiveRecord::Rollback
        end

        response = GitHub::Client.query(GitHub::RepositoryQuery, variables: { owner: owner, name: name })

        if data = response.data
          if data.errors[:repository].present?
            errors.add(:base, data.errors[:repository].join(", "))

            raise ActiveRecord::Rollback
          else
            repository.update(details: data.as_json["data"]["repository"])
          end
        else
          if response.errors.messages[:data].present?
            errors.add(:base, response.errors.messages[:data].join(", "))
          else
            errors.add(:base, "Something wrong")
          end

          raise ActiveRecord::Rollback
        end
      end
    end

    private

    def validate_repository_name
      owner, name = repository_name.split("/")

      unless name
        errors.add(:repository_name, :invalid)
      end
    end
  end
end

