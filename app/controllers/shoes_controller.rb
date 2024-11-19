class ShoesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_shoe, only: [:show, :edit, :update, :destroy]
  before_action :authorize_shoe_owner!, only: [:edit, :update, :destroy]

  def index
    @shoes = Shoe.all
  end

  def filter
    @shoes = Shoe.all
    @shoes = @shoes.where(brand: params[:brand]) if params[:brand].present?
    @shoes = @shoes.where(size: params[:size]) if params[:size].present?
    @shoes = @shoes.where("price_per_day <= ?", params[:max_price]) if params[:max_price].present?
    @shoes = @shoes.order(price_per_day: params[:sort_price]) if params[:sort_price].present?

    render :index
  end

  def show
  end

  def new
    @shoe = Shoe.new
  end

  def create
    @shoe = current_user.shoes.build(shoe_params)
    if @shoe.save
      redirect_to @shoe, notice: 'Your shoe has been successfully listed for rent!'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @shoe.update(shoe_params)
      redirect_to @shoe, notice: 'Your shoe details have been successfully updated!'
    else
      render :edit
    end
  end

  def destroy
    @shoe.destroy
    redirect_to shoes_url, notice: 'Your shoe has been successfully removed from the listings.'
  end

  def my_list
      @shoes = current_user.shoes
  end

  private

  def set_shoe
    @shoe = Shoe.find(params[:id])
  end

  def shoe_params
    params.require(:shoe).permit(:brand, :size, :condition, :price_per_day, :description, :availability, :shoe_url)
  end

  def authorize_shoe_owner!
    unless @shoe.user == current_user
      redirect_to shoes_path, alert: 'You are not authorized to edit or delete this shoe listing.'
    end
  end
end
