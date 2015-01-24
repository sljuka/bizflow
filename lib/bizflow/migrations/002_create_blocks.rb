Sequel.migration do
  up do
    create_table(:blocks) do
      primary_key :id
      foreign_key :process_id, :processes
      foreign_key :block_blueprint_id, :block_blueprints
      String :name, :null => false
      String :type, :null => false
    end
  end

  down do
    drop_table(:blocks)
  end
end
