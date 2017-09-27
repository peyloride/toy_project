module ToysHelper
  def is_lendable(toy)
    @lend = Lend.where(toy_id: toy.id)

    if @lend.present?
      if (@lend.last.created_at < 1.month.ago) && (toy.user_id != current_user.id)
        return true
      else
        return false
      end
    else
      if toy.user_id != current_user.id
        return true
      end
    end
    return false
  end

  def next_lend_time(toy)
    @lend = Lend.where(toy_id: toy.id)

    if @lend.present?
      "Sorry, already borrowed from someone else. Can't borrowed again until, #{(@lend.last.created_at + 1.month).strftime('%Y-%m-%d')}"
    end
  end
end
