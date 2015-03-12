require "spec_config"

require "bizflow/lib/process_builder"
require "bizflow/business_model/process"
require "bizflow/business_model/task"
require "bizflow/business_model/task_action"

describe Bizflow::BusinessModel::Process, process: true do

  before :each do

    # schema
    process_bp = create(:process_bp, name: "process1", start: "action1")
    action_bp1 = create(:action_bp, process_blueprint: process_bp, name: "action1")
    action_bp2 = create(:action_bp, process_blueprint: process_bp, name: "action2")
    action_bp3 = create(:action_bp, process_blueprint: process_bp, name: "action3")

    task_bp1 = create(:task_bp, action_blueprint: action_bp1, name: "task1")
    task_bp2 = create(:task_bp, action_blueprint: action_bp1, name: "task2")
    task_bp3 = create(:task_bp, action_blueprint: action_bp2, name: "task3")
    task_bp4 = create(:task_bp, action_blueprint: action_bp3, name: "task4")

    # actual process
    @process = Bizflow::Lib::ProcessBuilder.new.build(process_bp.id, 1)

  end

  it "can run" do

    bp = Bizflow::BusinessModel::Process.new(@process)

    actions = bp.actions
    expect(bp.start_action_id).to eq actions.first.id
    expect(actions.map(&:name)).to eq ["action1", "action2", "action3"]

    bp.run(1)

    expect(bp.current).to eq actions.first

    tasks = Bizflow::BusinessModel::Task.wraps(bp.current.tasks)
    expect(tasks.count).to eq 2
    expect(tasks.map(&:name)).to eq ["task1", "task2"]

    ba = Bizflow::BusinessModel::TaskAction.new(bp.current)
    expect(ba.active.map(&:id)).to eq tasks.map(&:id)

    tasks[0].finish
    tasks[1].finish

    expect(bp.current).to eq actions[1]

  end

end
