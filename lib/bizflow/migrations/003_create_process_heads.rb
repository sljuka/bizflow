Sequel.migration do
  up do
    create_table(:process_heads) do
      primary_key :id
      foreign_key :process_id, :processes
      foreign_key :block_id, :blocks
      index [:process_id, :block_id], :unique=>true
    end
  end

  down do
    drop_table(:process_heads)
  end
end
