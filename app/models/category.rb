# == Schema Information
#
# Table name: categories
#
#  id            :bigint           not null, primary key
#  name          :string           not null
#  technology_id :bigint           not null
#
# Indexes
#
#  index_categories_on_technology_id_and_name  (technology_id,name) UNIQUE
#
class Category < ApplicationRecord
  has_many :repositories, dependent: :destroy
  belongs_to :technology

  validates :name, presence: true, uniqueness: { scope: [:technology_id] }
end
