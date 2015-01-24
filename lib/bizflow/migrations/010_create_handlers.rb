Sequel.migration do
  up do
    create_table(:handlers) do
      primary_key :id
      foreign_key :block_id, :blocks
      foreign_key :handler_blueprint_id, :handler_blueprints
      TrueClass :finished, :default => false
      TrueClass :error, :default => false
      String :error_text
    end
  end

  down do
    drop_table(:handlers)
  end
end
