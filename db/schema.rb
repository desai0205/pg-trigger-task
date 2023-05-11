# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2023_05_09_202417) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "invoices", force: :cascade do |t|
    t.integer "serial_number", null: false
    t.string "name"
    t.integer "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["serial_number"], name: "index_invoices_on_serial_number"
  end

  # no candidate create_trigger statement could be found, creating an adapter-specific one
  execute("CREATE TRIGGER invoice_line_items_change_trigger AFTER INSERT OR DELETE OR UPDATE ON \"invoices\" FOR EACH ROW EXECUTE FUNCTION notify_invoice_line_items_change()")

  # no candidate create_trigger statement could be found, creating an adapter-specific one
  execute(<<-SQL)
CREATE OR REPLACE FUNCTION public.notify_invoice_line_items_change()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
      BEGIN
        PERFORM pg_notify('invoice_line_items_change', '');
        RETURN NEW;
      END;
      $function$
  SQL

end
