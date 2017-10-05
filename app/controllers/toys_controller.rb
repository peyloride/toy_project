class ToysController < ApplicationController
  before_action :authenticate_user!
  before_action :set_toy, only: [:edit, :update, :destroy]

  def index
    @toys = Toy.all
  end

  def like
    @toy = Toy.find(params[:toy_id])
    current_user.likes @toy
    respond_to do |format|
      format.js
    end
  end

  def my_toys
    @toys = current_user.toys
    @lended_toys = Lend.where(borrower_id: current_user.id, is_accepted: true).map { |lend| lend.toy}
  end

  def show
    @toy = Toy.find(params[:id])
    @lends = Lend.where(toy_id: @toy.id, is_accepted: nil)

    if Lend.find_by(toy_id: @toy.id, is_accepted: true).present?
      @lender = Lend.find_by(toy_id: @toy.id, is_accepted: true).lender
      @lend = Lend.find_by(toy_id: @toy.id, is_accepted: true)
    end
  end

  def new
    @toy = Toy.new
  end

  def edit
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
