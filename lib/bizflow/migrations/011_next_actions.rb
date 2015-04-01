Sequel.migration do
  up do
    create_table(:next_actions) do
      primary_key :id
      foreign_key :action_id, :actions
      foreign_key :next_id, :actions
      String :ending
    end
  end

  down do
    drop_table(:next_actions)
  end
end
