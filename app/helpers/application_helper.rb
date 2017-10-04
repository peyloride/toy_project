module ApplicationHelper
  def user_allowed
    user_signed_in? && (current_user.id == @toy.user_id)
  end

  def user_allowed_comment(comment)
    user_signed_in? && (current_user.id == comment.user_id)
  end

  def full_user_name(user)
    user.first_name + " " + user.last_name
  end
end
