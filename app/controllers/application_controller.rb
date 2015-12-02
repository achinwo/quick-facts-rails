class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected
	  def get_facts
			@facts = params[:query].blank? ? 
						Fact.all
						:
						Fact.all.map {|f| f if f.content.include? params[:query]}.compact

			if params[:id]
			  	id = params[:id].to_i
		      	@facts = @facts.map {|f| f if f.id < id}.compact
			end
		    puts session
		    @facts = @facts.first(6)
	  end
end
