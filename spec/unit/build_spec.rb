require "spec_helper"

require "bizflow/command/build_command"
require "bizflow/command/setup_db_command"

describe "build command" do

  let(:config) {
    {
      base_path: File.expand_path("#{File.dirname(__FILE__)}"),
      source_path: File.expand_path("#{File.dirname(__FILE__)}/biz_definition"),
      db_path: "spec/unit/test_db/bf_test.db"
    }
  }

  before :each do
    Bizflow::SetupDbCommand.run(config, nil)
    
    Dir["#{File.dirname(__FILE__)}/../../lib/bizflow/data_model/*.rb"].each { |path| require_relative path }

    Bizflow::DataModel::TaskBlueprint.where('id > 0').delete
    Bizflow::DataModel::HandlerBlueprint.where('id > 0').delete
    Bizflow::DataModel::ActionBlueprint.where('id > 0').delete
    Bizflow::DataModel::ProcessBlueprint.where('id > 0').delete

    Bizflow::BuildCommand.run(config, nil)
  end

  it "builds" do

    expect(Bizflow::DataModel::ProcessBlueprint.count).to eq(1)
    expect(Bizflow::DataModel::ActionBlueprint.count).to eq(4)
    expect(Bizflow::DataModel::TaskBlueprint.count).to eq(5)

  end
end