# == Schema Information
#
# Table name: categories
#
#  id            :bigint           not null, primary key
#  name          :string           not null
#  technology_id :bigint           not null
#  user_id       :bigint           not null
#
# Indexes
#
#  index_categories_on_user_id_and_name           (user_id,name) UNIQUE
#  index_categories_on_user_id_and_technology_id  (user_id,technology_id) UNIQUE
#
class Category < ApplicationRecord
  has_many :repositories
end
