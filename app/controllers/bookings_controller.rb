class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_shoe, only: [:new, :create]
  before_action :set_booking, only: [:show, :edit, :update]

  def index
    @booking = current_user.bookings
  end

  def new
    @booking = @shoe.bookings.new
  end

  def create
    @booking = @shoe.bookings.new(booking_params)
    @booking.user = current_user

    if @booking.save
      redirect_to bookings_path, notice: 'Your booking request has been sent to the owner.'
    else
      render :new
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

  private

  def set_shoe
    @shoe = Shoe.find(params[:shoe_id])
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :status, :message)
  end

end
