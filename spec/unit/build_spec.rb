require "spec_helper"

require "bizflow/command/build_command"
require "bizflow/command/setup_db_command"

describe "build command" do

  let(:config) {
    {
      base_path: File.expand_path("#{File.dirname(__FILE__)}"),
      source_path: File.expand_path("#{File.dirname(__FILE__)}/biz_definition"),
      db_path: File.expand_path("#{File.dirname(__FILE__)}/test_db/bf_test.db")
    }
  }

  before :each do
    Bizflow::SetupDbCommand.run(config, nil)
    
    Dir["#{File.dirname(__FILE__)}/../../lib/bizflow/model/*.rb"].each { |path| require_relative path }

    Bizflow::Model::TaskBlueprint.where('id > 0').delete
    Bizflow::Model::HandlerBlueprint.where('id > 0').delete
    Bizflow::Model::BlockBlueprint.where('id > 0').delete
    Bizflow::Model::ProcessBlueprint.where('id > 0').delete

    Bizflow::BuildCommand.run(config, nil)
  end

  it "builds", build: true do

    expect(Bizflow::Model::ProcessBlueprint.count).to eq(1)
    expect(Bizflow::Model::BlockBlueprint.count).to eq(4)
    expect(Bizflow::Model::TaskBlueprint.count).to eq(5)

  end
end