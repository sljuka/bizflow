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

end
