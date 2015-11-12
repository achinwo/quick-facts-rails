class SearchPagesController < ApplicationController

	def home
		@facts = Fact.all
	end

	def search
		query = params[:query]
		@facts = Fact.all.map {|f| f if f.content.include? query}.compact
	end
end
