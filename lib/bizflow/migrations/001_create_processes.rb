Sequel.migration do
  up do
    create_table(:processes) do
      primary_key :id
      foreign_key :process_blueprint_id, :process_blueprints
      Integer :start_action_id
      String :name
      String :description, :text=>true
      Integer :creator_id, :null=>false
      String :pid, :null => false
      Integer :runner_id
      DateTime :created_at, default: Sequel::CURRENT_TIMESTAMP
      DateTime :runned_at
      DateTime :jumped_at
      DateTime :finished_at
    end
  end

  down do
    drop_table(:processes)
  end
end
