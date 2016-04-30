class TestJob < ActiveJob::Base
  include ActiveJob::Users
  queue_as :default

  def perform
  end
end
