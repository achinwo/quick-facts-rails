class FactsController < ApplicationController

  	def index
  		query = params[:search]
  		@facts = Fact.all.map {|fact| fact if fact.content.include? query}.compact
  		#render plain:@facts
  	end

  	def new
  		@fact = Fact.new
  	end

    def edit
      @fact = Fact.find(params[:id])

      respond_to do |format|
        format.html { render partial: 'shared/edit_fact', locals: {'fact' => @fact} }
        format.js
      end
    end

  	def create
  		@fact = Fact.new(fact_params)
  		@fact.save

      respond_to do |format|
        format.html { render @fact }
        format.js
      end
  	end

    def update
      @fact = Fact.find(params[:id])
      @fact.update_attributes(fact_params)
      
      respond_to do |format|
        format.html {render fact}
        format.js
      end
    end

    def destroy
      @fact = Fact.find(params[:id])
      @fact.destroy

      respond_to do |format|
        format.html { redirect_to facts_url }
        format.js   { render :layout => false }
      end
    end

  	private
  		def fact_params
  			params.require(:fact).permit(:content)
  		end
end
