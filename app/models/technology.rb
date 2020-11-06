# == Schema Information
#
# Table name: technologies
#
#  id      :bigint           not null, primary key
#  name    :string           not null
#  user_id :bigint           not null
#
# Indexes
#
#  index_technologies_on_user_id_and_name  (user_id,name) UNIQUE
#
class Technology < ApplicationRecord
  has_many :categories, dependent: :destroy

  validates :name, presence: true, uniqueness: { scope: [:user_id] }
end
