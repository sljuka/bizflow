Sequel.migration do
  up do
    create_table(:tasks) do
      primary_key :id
      foreign_key :block_id, :blocks
    end
  end

  down do
    drop_table(:tasks)
  end
end
