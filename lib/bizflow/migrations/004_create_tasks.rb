Sequel.migration do
  up do
    create_table(:tasks) do
      primary_key :id
      foreign_key :block_id, :blocks
      foreign_key :task_blueprint_id, :task_blueprints
      String :task
    end
  end

  down do
    drop_table(:tasks)
  end
end
