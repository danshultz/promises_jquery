class Pet < ActiveRecord::Base
  attr_accessible :kind, :name, :person_id
  belongs_to :person
end
