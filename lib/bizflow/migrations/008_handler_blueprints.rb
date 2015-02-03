Sequel.migration do
  up do
    create_table(:handler_blueprints) do
      primary_key :id
      foreign_key :action_blueprint_id, :action_blueprints
      String :name, :null => false
      String :namespace, :null => false
      String :description
    end
  end

  down do
    drop_table(:handler_blueprints)
  end
end
