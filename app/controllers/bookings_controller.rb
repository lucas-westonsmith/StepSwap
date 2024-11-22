class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_shoe, only: [:new, :create]
  before_action :set_booking, only: [:show, :edit, :update, :accept, :decline]

  def index
    @bookings = current_user.bookings
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.shoe = @shoe

    if @booking.save
      redirect_to shoe_path(@shoe), notice: 'Your booking request has been sent to the owner.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @booking
  end

  def edit
    @booking
  end

  def update
    if @booking.update(booking_params)
      redirect_to @booking, notice: 'Your booking has been updated.'
    else
      render :edit
    end
  end

  def accept
    if @booking.update(status: 'confirmed')
      redirect_to my_list_shoes_path, notice: 'Booking was successfully accepted.'
    else
      redirect_to my_list_shoes_path, alert: 'Failed to accept the booking.'
    end
  end

  def decline
    if @booking.update(status: 'canceled')
      redirect_to my_list_shoes_path, notice: 'Booking was successfully declined.'
    else
      redirect_to my_list_shoes_path, alert: 'Failed to decline the booking.'
    end
  end

  private

  def set_shoe
    @shoe = Shoe.find(params[:shoe_id])
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :message, :payment_method)
  end
end
