class StaticPagesController < ApplicationController
  def home
  	@fact = Fact.new
  end

  def help
  end

  def search
  	query = params[:search]
  	@facts = Fact.all.map {|fact| fact if fact.content.include? query}
  	render 'home'
  end
end
