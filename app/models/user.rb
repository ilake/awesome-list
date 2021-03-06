# == Schema Information
#
# Table name: users
#
#  id       :bigint           not null, primary key
#  email    :string           not null
#  name     :string           not null
#  provider :string           not null
#  uid      :string           not null
#
class User < ApplicationRecord
  devise :omniauthable
  has_many :technologies, dependent: :destroy
end
