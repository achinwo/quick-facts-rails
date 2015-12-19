class FactsController < ApplicationController

  	def index
  		query = (params[:query] || params[:q] || '').downcase
      user_ids = [params.fetch(:user_id, nil)]
      user_ids.push(nil) if params.fetch('include_anon', false)
      @facts = Fact.all.where({user_id: user_ids.uniq})
      @facts.map {|fact| fact if fact.content.downcase.include? query}.compact
      
      respond_to do |format|
        format.html
        format.json { render json: @facts}
      end
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
      puts "PARAMS #{fact_params}"
      @fact.update_attribute(:user_id, current_user.id) if current_user
  		@fact.save

      respond_to do |format|
        format.html { render @fact }
        format.js
        format.json { render json: @fact }
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
  			params.require(:fact).permit(:content, :user_id)
  		end
end
