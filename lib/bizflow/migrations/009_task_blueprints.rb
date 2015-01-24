Sequel.migration do
  up do
    create_table(:task_blueprints) do
      primary_key :id
      foreign_key :block_blueprint_id, :block_blueprints
      String :name, :null => false
      String :roles
      String :description
      TrueClass :auto_assign, :default => false
    end
  end

  down do
    drop_table(:task_blueprints)
  end
end
