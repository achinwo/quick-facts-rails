
class GroupsController < ApplicationController

  def index
  	if user = User.find(params[:user_id])
  		res = "#{user.name}'s groups: #{user.groups.map(&:name).join(', ')}"
  	else
  		res = "No such user"
  	end 
  	render plain: res
  end

  def create

  end

  def new
  	@group = Group.new
  end

  private

  	def group_params
  		params.require(:group).permit(:name, :user_id)
  	end
end
