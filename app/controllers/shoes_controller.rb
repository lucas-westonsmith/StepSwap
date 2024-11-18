class ShoesController < ApplicationController
  before_action :set_shoe, only: [:show, :edit, :update, :destroy]

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

  private

  def set_shoe
    @shoe = Shoe.find(params[:id])
  end

  def shoe_params
    params.require(:shoe).permit(:brand, :size, :condition, :price_per_day, :description, :availability, :shoe_url)
  end
end
