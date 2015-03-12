Sequel.migration do
  up do
    create_table(:next_action_blueprints) do
      primary_key :id
      foreign_key :action_id, :action_blueprints
      foreign_key :next_action_id, :action_blueprints
    end
  end

  down do
    drop_table(:next_actions)
  end
end
