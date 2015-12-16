class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session #:exception
  include SessionsHelper

  protected
	  def get_facts
	  		if current_user
	  			@facts = current_user.facts
	  		else
	  			@facts = Fact.where(user_id: nil)
	  		end

			if !params[:query].blank?
				query = params[:query].downcase
				@facts = @facts.map {|f| f if f.content.downcase.include? query}.compact
			end

			if params[:id]
			  	id = params[:id].to_i
		      	@facts = @facts.map {|f| f if f.id < id}.compact
			end

		    @facts = @facts.first(6)
	  end
end
