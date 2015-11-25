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
  		@fact.save

      respond_to do |format|
        format.html { render @fact }
        format.js
      end
  	end

  	private
  		def fact_params
  			params.require(:fact).permit(:content)
  		end
end
