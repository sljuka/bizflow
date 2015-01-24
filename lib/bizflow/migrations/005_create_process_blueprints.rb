Sequel.migration do
  up do
    create_table(:process_blueprints) do
      primary_key :id
    end
  end

  down do
    drop_table(:process_blueprints)
  end
end
