require "spec_config"
require "bizflow/lib/blueprint_builder"
require "bizflow/lib/semantic_builder"

describe "build command", command: true do

  before :each do
  	
  	@repo = Bizflow::SemanticModel::DomainRepo.new
    builder = Bizflow::Lib::SemanticBuilder.new(File.expand_path("#{File.dirname(__FILE__)}/../dsl_scripts"))
    builder.repo = @repo
  	builder.build

  end

  it "persists process blueprints" do

  	Bizflow::Lib::BlueprintBuilder.new.build(@repo)
  	expect(Bizflow::DataModel::ProcessBlueprint.count).to eq 1

  end

  it "persists action blueprints" do

  	Bizflow::Lib::BlueprintBuilder.new.build(@repo)
  	expect(Bizflow::DataModel::ActionBlueprint.count).to eq 4

  end

  it "persists next_action blueprints" do

  	Bizflow::Lib::BlueprintBuilder.new.build(@repo)
  	expect(Bizflow::DataModel::NextActionBlueprint.count).to eq 5

  end

  it "persists task blueprints" do

  	Bizflow::Lib::BlueprintBuilder.new.build(@repo)
  	expect(Bizflow::DataModel::TaskBlueprint.count).to eq 6

  end

end
