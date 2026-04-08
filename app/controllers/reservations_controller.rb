class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @reservations = current_user.reservations.includes(:room).order(created_at: :desc)
  end

  def new
  end

  def confirm
    @reservation = current_user.reservations.build(reservation_params)
    @room = Room.find(params[:reservation][:room_id])
    if @reservation.invalid?
      render "rooms/show", status: :unprocessable_entity
    end
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
    @room = @reservation.room
  end

  def update
    if @reservation.update(reservation_params)
      flash[:notice] = "予約情報を更新しました"
      redirect_to reservations_path(@reservation.room)
    else
      render "edit", status: :unprocessable_entity
    end
  end

  def destroy
    @reservation.destroy
    flash[:notice] = "予約情報を削除しました"
    redirect_to reservations_path(@reservation.room), status: :see_other
  end

  private

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def reservation_params
    params.require(:reservation).permit(:checkin_date, :checkout_date, :people, :room_id)
  end
end
