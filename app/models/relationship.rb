class Relationship < ActiveRecord::Base
	belongs_to :fact
	belongs_to :category
end
