require "spec_config"

require "bizflow/business_model/process"
require "bizflow/business_model/task_action"
require 'bizflow/lib/process_builder'

describe Bizflow::BusinessModel::Process, process: true do

  before(:each) do

    @process_bp = create(:process_bp, name: "new_process", start: "action_0")

    action_bp0 = create(:input_bp, process_blueprint: @process_bp, name: "action_0")
    action_bp1 = create(:action_bp, process_blueprint: @process_bp, name: "action_1")
    action_bp2 = create(:action_bp, process_blueprint: @process_bp, name: "action_2")
    action_bp3 = create(:action_bp, process_blueprint: @process_bp, name: "action_3")

    create(:next_action_bp, action_blueprint: action_bp0, next_blueprint: action_bp1, ending: "action_1")
    create(:next_action_bp, action_blueprint: action_bp0, next_blueprint: action_bp2, ending: "action_2")

    create(:next_action_bp, action_blueprint: action_bp1, next_blueprint: action_bp2)
    create(:next_action_bp, action_blueprint: action_bp2, next_blueprint: action_bp3)

    @process_builder = Bizflow::Lib::ProcessBuilder.new

  end

  it "creates and prepares a new process via #build" do

    process = @process_builder.build(@process_bp.id, 1)

    expect(Bizflow::DataModel::Process.count).to eq 1
    expect(process.name).to eq "new_process"
    
    p = Bizflow::DataModel::Process.first

    expect(Bizflow::DataModel::Action.count).to eq 4
    expect(p.actions.count).to eq 4
    expect(p.actions.map(&:name)).to eq ["action_0", "action_1", "action_2", "action_3"]
    expect(p.actions.map(&:type)).to eq ["input", "task", "task", "task"]

    biz_actions = Bizflow::BusinessModel::TaskAction.wraps(p.actions)
    expect(biz_actions[0].next_actions.map(&:next)).to eq [p.actions[1], p.actions[2]]
    expect(biz_actions[0].next_actions.map(&:ending)).to eq ["action_1", "action_2"]


    expect(biz_actions[1].next_action).to eq p.actions[2]

    heads = Bizflow::DataModel::Head.all
    expect(heads.count).to eq 1
    expect(p.heads.count).to eq 1

    expect(p.start_action_id).to eq p.actions[0].id

  end

end
