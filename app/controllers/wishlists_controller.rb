class WishlistsController < ApplicationController
  before_action :authenticate_user!

  def show
    @wishlist = current_user.wishlist || current_user.create_wishlist
  end

  def add_item
    @wishlist = current_user.wishlist || current_user.create_wishlist
    @shoe = Shoe.find(params[:shoe_id])

    unless @wishlist.shoes.include?(@shoe)
      @wishlist.shoes << @shoe
      flash[:notice] = 'Shoe added to your wishlist!'
    else
      flash[:alert] = 'Shoe is already in your wishlist.'
    end
    # Check if the referer is the shoe details page or the index page
    if params[:from_action] == "index"
      # If the request came from the index page, redirect to the index page
      redirect_to shoes_path
    else
      # Otherwise, stay on the shoe show page
      redirect_to shoe_path(@shoe)
    end
  end

  def remove_item
    @wishlist = current_user.wishlist
    @shoe = Shoe.find(params[:shoe_id])

    if @wishlist.shoes.include?(@shoe)
      @wishlist.shoes.delete(@shoe)
      flash[:notice] = 'Shoe removed from your wishlist.'
    else
      flash[:alert] = 'Shoe is not in your wishlist.'
    end

    if params[:from_action] == "index"
      redirect_to shoes_path
    elsif params[:from_action] == "wishlist"
      redirect_to wishlist_path(@wishlist.id)
    else
      # Otherwise, stay on the shoe show page
      redirect_to shoe_path(@shoe)
    end
  end
end
