class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_booking, only: [:new, :create, :edit, :update]
  before_action :set_shoe, only: [:new, :create] # Ajout de la méthode set_shoe
  before_action :set_review, only: [:edit, :update, :destroy]

  def new
    @review = Review.new
  end

  def create
    Rails.logger.debug "Starting review creation"
    @review = Review.new(review_params) # Utilisation de build pour lier la review à la réservation
    @review.user = current_user
    @review.booking = @booking # Associer la chaussure via la réservation

    Rails.logger.debug "Review params: #{review_params.inspect}"

    if @review.save
      flash[:notice] = "Review successfully added!"
      redirect_to bookings_path
    else
      Rails.logger.debug "Review creation failed: #{@review.errors.full_messages}"
      flash[:alert] = "There was an issue with your review."
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @review.update(review_params)
      redirect_to bookings_path, notice: 'Review successfully updated!'
    else
      render :edit
    end
  end

  def destroy
    @review.destroy
    redirect_to bookings_path, notice: 'Review was successfully deleted.'
  end

  private

  def set_booking
    @booking = Booking.find(params[:booking_id])
  end

  def set_shoe
    @shoe = Shoe.find(params[:shoe_id]) # Nouvelle méthode pour récupérer la chaussure
  end

  def set_review
    @review = @booking.reviews.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
