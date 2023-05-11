class CreateTriggerInvoicesUpdate < ActiveRecord::Migration[5.2]
  def up
    execute <<-SQL
      CREATE OR REPLACE FUNCTION notify_invoice_line_items_change()
      RETURNS TRIGGER AS $$
      BEGIN
        PERFORM pg_notify('invoice_line_items_change', '');
        RETURN NEW;
      END;
      $$ LANGUAGE plpgsql;

      CREATE TRIGGER invoice_line_items_change_trigger
      AFTER INSERT OR UPDATE OR DELETE ON invoices
      FOR EACH ROW
      EXECUTE PROCEDURE notify_invoice_line_items_change();
    SQL
  end

  def down
    execute <<-SQL
      DROP TRIGGER invoice_line_items_change_trigger ON invoices
    SQL
  end
end 
