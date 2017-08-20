class GramsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
  end

  def new
    @gram = Gram.new
  end

  def create
    @gram = current_user.grams.create(gram_params)
    if @gram.valid?
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    # find_by_id returns nil if there is no id to find
    @gram = Gram.find_by_id(params[:id])
    render_status if @gram.blank?
  end

  def edit
    @gram = Gram.find_by_id(params[:id])
    return render_status if @gram.blank?
    return render_status(:forbidden) if @gram.user != current_user
  end
  
  def update
    @gram = Gram.find_by_id(params[:id])
    return render_status if @gram.blank?
    return render_status(:forbidden) if @gram.user != current_user
    
    @gram.update_attributes(gram_params)

    if @gram.valid?
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @gram = Gram.find_by_id(params[:id])
    return render_status if @gram.blank?
    return render_status(:forbidden) if @gram.user != current_user
    @gram.destroy
    redirect_to root_path
  end
  
  
  private

  def gram_params
    params.require(:gram).permit(:message)
  end

  def render_status(status=:not_found)
    render plain: "#{status.to_s.titleize} :<", status: status
  end 
  
end
