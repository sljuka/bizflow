Sequel.migration do
  up do
    create_table(:blocks) do
      primary_key :id
      Integer :process_id, :null => false
      String :type, :null => false
    end
  end

  down do
    drop_table(:blocks)
  end
end
