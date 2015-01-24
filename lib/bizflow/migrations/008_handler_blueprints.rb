Sequel.migration do
  up do
    create_table(:handler_blueprints) do
      primary_key :id
      foreign_key :block_blueprint_id, :block_blueprints
      String :path, :null => false
      String :constant, :null => false
    end
  end

  down do
    drop_table(:handler_blueprints)
  end
end
