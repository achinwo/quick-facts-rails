class Group < ActiveRecord::Base
	belongs_to :user
	has_many   :facts
	validates :name, presence: true, uniqueness: {case_sensitive: false}
end
