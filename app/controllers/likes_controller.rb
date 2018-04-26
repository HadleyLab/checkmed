class LikesController < ApplicationController

  def create
    checklist = Checklist.find(params[:likable_id])
    current_user.like(checklist)
    redirect_to :back
  end

  def destroy
    checklist = Checklist.find(params[:likable_id])
    current_user.dislike(checklist)
    redirect_to :back
  end

end