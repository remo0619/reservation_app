class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @rooms = current_user.rooms
  end

  def search
    @rooms = Room.all

    if params[:area].present?
      @rooms = @rooms.where('address LIKE ?', "%#{params[:area]}%")
    end

    if params[:keyword].present?
      @rooms = @rooms.where('name LIKE ? OR introduction LIKE ?', "%#{params[:keyword]}%", "%#{params[:keyword]}%")
    end
  end

  def new
    @room = Room.new
  end

  def create
    @room = current_user.rooms.build(room_params)
    if @room.save
      redirect_to room_path(@room)
    else
      render "new", status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @room.update(room_params)
      flash[:notice] = "施設情報を更新しました"
      redirect_to room_path(@room)
    else
      render "edit", status: :unprocessable_entity
    end
  end

  def destroy
    @room.destroy
    flash[:notice] = "施設情報を削除しました"
    redirect_to user_path(current_user)
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:name, :introduction, :price, :address, :image)
  end
end
