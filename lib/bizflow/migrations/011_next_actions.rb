Sequel.migration do
  up do
    create_table(:next_actions) do
      primary_key :id
      foreign_key :action_id, :actions
      foreign_key :next_action_id, :actions
    end
  end

  down do
    drop_table(:next_actions)
  end
end
