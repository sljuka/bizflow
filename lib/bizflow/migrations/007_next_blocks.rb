Sequel.migration do
  up do
    create_table(:next_blocks) do
      primary_key :id
      foreign_key :block_id, :block_blueprints
      foreign_key :next_block_id, :block_blueprints
    end
  end

  down do
    drop_table(:next_blocks)
  end
end
