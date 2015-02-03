Sequel.migration do
  up do
    create_table(:heads) do
      primary_key :id
      foreign_key :process_id, :processes
      foreign_key :action_id, :actions
      index [:process_id, :action_id], :unique=>true
    end
  end

  down do
    drop_table(:process_heads)
  end
end
