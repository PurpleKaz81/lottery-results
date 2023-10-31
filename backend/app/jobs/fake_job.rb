class FakeJob < ApplicationJob
  queue_as :default

  def perform(*)
    puts "I'm starting the fake job"
    sleep 3
    puts 'DONE!!!!!!'
  end
end
