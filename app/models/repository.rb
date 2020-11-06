# == Schema Information
#
# Table name: repositories
#
#  id          :bigint           not null, primary key
#  details     :jsonb
#  name        :string           not null
#  category_id :bigint           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_repositories_on_user_id_and_name  (user_id,name) UNIQUE
#
class Repository < ApplicationRecord
end
