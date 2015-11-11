class FactsController < ApplicationController
  	
  	def index
  		query = params[:search]
  		@facts = Fact.all.map {|fact| fact if fact.content.include? query}.compact
  		#render plain:@facts
  	end

  	def new
  		@fact = Fact.new
  	end

  	def create
  		@fact = Fact.new(fact_params)
  		if @fact.save
  			render @fact
  		else
  			render 'new'
  		end
  	end

  	private
  		def fact_params
  			params.require(:fact).permit(:content)
  		end
end
