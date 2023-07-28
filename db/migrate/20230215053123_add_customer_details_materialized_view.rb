class AddCustomerDetailsMaterializedView < ActiveRecord::Migration[7.0]
  # this method is responsible for create the customer details view
  def up
    # this query is responsible for creating the materialized view
    execute %{
      CREATE MATERIALIZED VIEW customer_details AS
        SELECT
          customers.id as customer_id,
          customers.first_name as first_name,
          customers.last_name as last_name,
          addresses.street as street,
          addresses.city as city
        FROM
          customers
        JOIN addresses ON
          customers.id = addresses.customer_id
    }
    # this query is responsible for the create the unique index
    execute %{
      CREATE UNIQUE INDEX
        customer_details_customer_id
      ON
        customer_details(customer_id)
    }
  end

  # this method is responsible fot the drop the customer details view
  def down
    execute "DROP MATERIALIZED VIEW customer_details"
  end
end
