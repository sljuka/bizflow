Sequel.migration do
  up do
    create_table(:actions) do
      primary_key :id
      foreign_key :process_id, :processes
      foreign_key :action_blueprint_id, :action_blueprints
      String :name, :null => false
      String :type, :null => false
    end
  end

  down do
    drop_table(:actions)
  end
end
