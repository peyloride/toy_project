module ToysHelper
  def is_lendable(toy)
    @lends = Lend.where(toy_id: toy.id)

    if toy.user_id == current_user.id
      return false
    end

    if @lends.present?
      @lends.each do |lend|
        if lend.is_accepted == true
          return false
        end
      end
      return true
    else
      return true
    end
  end

  def is_request_sent(toy)
    Lend.where(toy_id: toy.id, is_accepted: nil, borrower_id: current_user.id).present?
  end

  def next_lend_time(toy)
    @lends = Lend.where(toy_id: toy.id, is_accepted: true)

    if @lends.present?
      "Sorry, already borrowed from someone else. Can't borrowed again until, #{(@lends.last.updated_at + 1.month).strftime('%d-%m-%Y')}"
    end

  end
end
