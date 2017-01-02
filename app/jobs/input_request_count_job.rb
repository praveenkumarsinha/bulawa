class InputRequestCountJob < ApplicationJob
  queue_as :default

  def perform(communication_key, time = Time.now.utc)
    CommunicationKey.increment_counter(:use_counter, communication_key.id)
    communication_key.update(used_at: time)
  end
end
