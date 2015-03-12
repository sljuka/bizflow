Sequel.migration do
  up do
    create_table(:tasks) do
      primary_key :id
      foreign_key :action_id, :actions
      foreign_key :task_blueprint_id, :task_blueprints
      Integer :assignee_id
      String :name
      DateTime :finished_at
    end
  end

  down do
    drop_table(:tasks)
  end
end
