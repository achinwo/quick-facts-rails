class SearchPagesController < ApplicationController
	def search
		@facts = get_facts

		respond_to do |format|
			format.html  { render 'search' }
			format.js
		end
	end
end
