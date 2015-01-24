Sequel.migration do
  up do
    create_table(:process_blueprints) do
      primary_key :id
      String :name
      String :description, :text => true
    end
  end

  down do
    drop_table(:process_blueprints)
  end
end
