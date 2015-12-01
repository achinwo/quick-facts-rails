class SearchPagesController < ApplicationController

	def home
		@facts = Fact.all
	end

	def add_fact
		if request.post?
		  	@fact = Fact.new(content: params.permit(:query).require(:query))

			if @fact.save
				flash.now[:success] = "Success!"
			else
				flash.now[:danger] = "Problem saving fact"
			end
		else
		  redirect_to root_path(query: params[:query])
		end
	end

	def search
		if params[:query].nil?
			params[:query] = ''
		end
		query = params[:query]
		@facts = Fact.order('updated_at DESC').all.map {|f| f if f.content.include? query}.compact

		respond_to do |format|
			format.html  { render 'search' }
			format.js
		end
	end


end
