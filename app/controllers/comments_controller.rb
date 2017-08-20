class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
     @gram = Gram.find_by_id(params[:gram_id])
     return render_status if @gram.blank?
     @gram.comments.create(comments_params.merge(user: current_user))
     redirect_to root_path
  end

  private

  def comments_params
    params.require(:comment).permit(:message)
  end

end
