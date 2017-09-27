module ApplicationHelper
  def user_allowed
    user_signed_in? && (current_user.id == @toy.user_id)
  end
end
