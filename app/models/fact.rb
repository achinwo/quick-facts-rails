class Fact < ActiveRecord::Base
	default_scope { order('updated_at DESC') }
	belongs_to :user
	has_one :relationship
	has_one :category, through: :relationship
	has_many   :attachments
end
