class Person < ActiveRecord::Base
  attr_accessible :age, :first_name, :last_name, :nickname
  has_many :pets
end
