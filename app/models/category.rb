class Category < ActiveRecord::Base
	has_many :relationships
	has_many :facts, through: :relationships
end
