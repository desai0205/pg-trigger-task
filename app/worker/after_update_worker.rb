class AfterUpdateWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(some)
    p some
  end
end
