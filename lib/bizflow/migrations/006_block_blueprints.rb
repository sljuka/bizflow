Sequel.migration do
  up do
    create_table(:block_blueprints) do
      primary_key :id
      foreign_key :process_blueprint_id, :process_blueprints
      String :name, :null => false
      String :type, :null => false
      String :description
    end
  end

  down do
    drop_table(:blocks)
  end
end
