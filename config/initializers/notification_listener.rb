# In config/initializers/notification_listener.rb
module ActiveRecord
  module ConnectionAdapters
    class PostgreSQLAdapter < AbstractAdapter
      def wait_for_notify(timeout = nil, &block)
        block.call if block_given?
        raw_connection.wait_for_notify(timeout)
      end
    end
  end
end

Rails.application.config.after_initialize do
  Thread.new do
    ActiveRecord::Base.connection_pool.with_connection do |conn|
      conn.execute("LISTEN invoice_line_items_change")
      loop do
        conn.wait_for_notify do |channel, _pid, payload|
          AfterUpdateWorker.perform_async("worker is working!")
        end
      end
    end
  end
end
