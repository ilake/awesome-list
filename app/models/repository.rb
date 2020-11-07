# == Schema Information
#
# Table name: repositories
#
#  id          :bigint           not null, primary key
#  details     :jsonb            not null
#  name        :string           not null
#  category_id :bigint           not null
#
# Indexes
#
#  index_repositories_on_category_id_and_name  (category_id,name) UNIQUE
#
class Repository < ApplicationRecord
  belongs_to :category, dependent: :destroy
  store :details, accessors: [:description, :forkCount, :stargazerCount, :updatedAt, :url]

  validates :name, presence: true, uniqueness: { scope: [:category_id] }
end
