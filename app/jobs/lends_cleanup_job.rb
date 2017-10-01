class LendsCleanupJob < ApplicationJob
  queue_as :default

  def perform(lend_id)
    @lend = Lend.find(lend_id)

    @lend.update(is_accepted: nil)
  end


end
