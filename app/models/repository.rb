# == Schema Information
#
# Table name: repositories
#
#  id      :bigint           not null, primary key
#  details :jsonb            not null
#  name    :string           not null
#  owner   :string           not null
#
# Indexes
#
#  index_repositories_on_owner_and_name  (owner,name) UNIQUE
#
class Repository < ApplicationRecord
  has_many :category_repository_relations
  has_many :categories, through: :category_repository_relations
  store :details, accessors: [:description, :forkCount, :stargazerCount, :updatedAt, :url]

  validates :name, presence: true, uniqueness: { scope: [:owner] }
end
