require "rails_helper"
RSpec.describe Invoice, type: :model do
  it "triggers InvoiceUpdateWorker when an invoice attirbute is changed" do
    invoice = Invoice.create!(serial_number: 20, amount: 100, name: "Other company")
    expect {
      invoice.update(amount: 123)
      AfterUpdateWorker.perform_async("worker is working!")
    }.to change(Sidekiq::Queues["default"], :size).by(1)
    #   AfterUpdateWorker.perform_later()
    # }.to have_enqueued_job(AfterUpdateWorker.perform_async("worker is working!"))
  end
end
