require "spec_config"

require "bizflow/business_model/process"
require 'bizflow/repo/test_repo'
require 'bizflow/lib/process_builder'

describe Bizflow::BusinessModel::Process, process: true do

  before(:each) do

    @process_bp = create(:process_bp, name: "new_process", start: "action_1")

    action_bp1 = create(:action_bp, process_blueprint: @process_bp, name: "action_1")
    action_bp2 = create(:action_bp, process_blueprint: @process_bp, name: "action_2")
    action_bp3 = create(:action_bp, process_blueprint: @process_bp, name: "action_3")

    next_action_bp1 = create(action: action_bp1, next_action: action_bp2)
    next_action_bp1 = create(action: action_bp2, next_action: action_bp3)

    @process_builder = Bizflow::Lib::ProcessBuilder.new

  end

  it "creates and prepares a new process via #build" do

    process = @process_builder.build(@process_bp.id, 1)

    expect(Bizflow::DataModel::Process.count).to eq 1
    expect(process.name).to eq "new_process"
    
    p = Bizflow::DataModel::Process.first

    expect(Bizflow::DataModel::Action.count).to eq 3
    expect(p.actions.count).to eq 3
    expect(p.actions.map(&:name)).to eq ["action_1", "action_2", "action_3"]

    heads = Bizflow::DataModel::Head.all
    expect(heads.count).to eq 1
    expect(p.heads.count).to eq 1

    expect(p.start_action_id).to eq p.actions[0].id

  end

end
