# == Schema Information
#
# Table name: category_repository_relations
#
#  id            :bigint           not null, primary key
#  category_id   :bigint           not null
#  repository_id :bigint           not null
#
# Indexes
#
#  category_repository_index  (category_id,repository_id) UNIQUE
#
class CategoryRepositoryRelation < ApplicationRecord
  belongs_to :category
  belongs_to :repository
end
