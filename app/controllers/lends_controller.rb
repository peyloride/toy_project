class LendsController < ApplicationController
  before_action :authenticate_user!

  def lend_request
    @toy = Toy.find(params[:toy_id])
    @lend = Lend.new(owner_id: @toy.user.id, borrower_id: current_user.id, toy_id: @toy.id)

    if @lend.save
      redirect_to @toy, notice: "Borrow request sent successfully"
    else
      redirect_to toys_path, notice: "You cant lend that item right now"
    end
  end

  def accept
    @toy = Toy.find(params[:toy_id])
    @lend = Lend.find(params[:lend_id])

    if @lend.update(is_accepted: true)
      LendsCleanupJob.set(wait: 1.month).perform_later @lend.id
      redirect_to @toy, notice: "Lend request accepted successfully"
    else
      redirect_to toys_path, notice: "Something went wrong."
    end
  end

  def refuse
    @toy = Toy.find(params[:toy_id])
    @lend = Lend.where(toy_id: @toy.id, owner_id: current_user.id)

    if @lend.update(is_accepted: false)
      redirect_to @toy, notice: "Lend request accepted successfully"
    else
      redirect_to toys_path, notice: "Something went wrong."
    end
  end

  def my_lends
    @pending_lends = Lend.where(owner_id: current_user.id, is_accepted: nil).uniq { |p| p.toy_id }
    @pending_toys = @pending_lends.map { |lend| lend.toy }

    @accepted_lends = Lend.where(owner_id: current_user.id, is_accepted: true).uniq { |p| p.toy_id }
    @accepted_toys = @accepted_lends.map { |lend| lend.toy }
  end
end
