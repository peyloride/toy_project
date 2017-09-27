class ToysController < ApplicationController
  before_action :authenticate_user!
  before_action :set_toy, only: [:edit, :update, :destroy]

  def index
    @toys = Toy.all
  end

  def my_toys
    @toys = current_user.toys
  end

  def show
    @toy = Toy.find(params[:id])
  end

  def new
    @toy = Toy.new
  end

  def edit
  end

  def lend
    @toy = Toy.find(params[:toy_id])
    @lend = Lend.new(owner_id: @toy.user.id, borrower_id: current_user.id, toy_id: @toy.id)

    if !Lend.where(toy_id: @toy.id).nil? || Lend.where(toy_id: @toy.id).last.created_at < 1.month.ago
      if @lend.save
        redirect_to @toy, notice: "Toy lended successfully"
      else
        redirect_to toys_path, notice: "You cant lend that item right now"
      end
    end
  end

  def create
    @toy = Toy.new(toy_params)
    @toy.user_id = current_user.id

    if @toy.save
      redirect_to @toy, notice: "Toy created successfully"
    else
      render :new
    end
  end

  def update
    if @toy.update(toy_params)
      redirect_to @toy, notice: "Toy updated successfully"
    else
      render :edit
    end
  end

  def destroy
    @toy.destroy
    redirect_to toys_path, notice: "Toy deleted successfully"
  end

  private
    def set_toy
      @toy = current_user.toys.find(params[:id])
    end

    def toy_params
      params.require(:toy).permit(:name, :toy_type, :image, :description)
    end
end
