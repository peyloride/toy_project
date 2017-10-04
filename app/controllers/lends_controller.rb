class LendsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_toy, only: [:lend_request, :accept, :refuse]
  before_action :set_lend, only: [:accept, :refuse]

  def lend_request
    @lend = Lend.new(owner_id: @toy.user.id, borrower_id: current_user.id, toy_id: @toy.id)

    if @lend.save
      redirect_to @toy, notice: "Borrow request sent successfully"
    else
      redirect_to toys_path, notice: "You cant lend that item right now"
    end
  end

  def accept
    if @lend.update(is_accepted: true)
      #Set cleaner job to make this toy available after 1 month
      LendsCleanupJob.set(wait: 1.month).perform_later @lend.id

      #If one of lend request is accepted, other requests must be refused.
      Lend.where(toy_id: @toy.id, is_accepted: nil).each do |lend|
        lend.update(is_accepted: false)
      end

      redirect_to @toy, notice: "Lend request accepted successfully"
    else
      redirect_to toys_path, notice: "Something went wrong."
    end
  end

  def refuse
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

  private

  def set_toy
    @toy = Toy.find(params[:toy_id])
  end

  def set_lend
    @lend = Lend.find(params[:lend_id])
  end
end
