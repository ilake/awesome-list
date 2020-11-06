# == Schema Information
#
# Table name: users
#
#  id   :bigint           not null, primary key
#  name :string
#
class User < ApplicationRecord
  has_many :technologies, dependent: :destroy
end
