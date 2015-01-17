Sequel.migration do
  up do
    create_table(:process_heads) do
      primary_key :id
      Integer :process_id, :null => false
      Integer :block_id, :null => false
    end
  end

  down do
    drop_table(:process_heads)
  end
end
