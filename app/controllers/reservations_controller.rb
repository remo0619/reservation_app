class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
  end

  def new
  end

  def confirm
    @reservation = current_user.reservations.build(reservation_params)
    @room = Room.find(params[:reservation][:room_id])
  end

  def create
    @reservation = current_user.reservations.build(reservation_params)
    if @reservation.save
      redirect_to reservations_path(@reservation.room)
    else
      render "new", status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def reservation_params
    params.require(:reservation).permit(:checkin_date, :checkout_date, :people, :room_id)
  end
end
