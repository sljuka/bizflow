require "spec_config"

require "bizflow/lib/process_builder"
require "bizflow/business_model/process"
require "bizflow/business_model/task"
require "bizflow/business_model/task_action"
require "bizflow/business_model/input_action"

describe Bizflow::BusinessModel::Process, process: true do

  before :each do

    # schema
    process_bp = create(:process_bp, name: "process1", start: "action0")

    action_bp0 = create(:input_bp, process_blueprint: process_bp, name: "action0")
    action_bp1 = create(:action_bp, process_blueprint: process_bp, name: "action1")
    action_bp2 = create(:action_bp, process_blueprint: process_bp, name: "action2")
    action_bp3 = create(:action_bp, process_blueprint: process_bp, name: "action3")

    create(:next_action_bp, action_blueprint: action_bp0, next_blueprint: action_bp1, ending: "action1")
    create(:next_action_bp, action_blueprint: action_bp0, next_blueprint: action_bp2, ending: "action2")

    create(:next_action_bp, action_blueprint: action_bp1, next_blueprint: action_bp2)
    create(:next_action_bp, action_blueprint: action_bp2, next_blueprint: action_bp3)

    task_bp1 = create(:task_bp, action_blueprint: action_bp1, name: "task1")
    task_bp2 = create(:task_bp, action_blueprint: action_bp1, name: "task2")
    task_bp3 = create(:task_bp, action_blueprint: action_bp2, name: "task3")
    task_bp4 = create(:task_bp, action_blueprint: action_bp3, name: "task4")

    # actual process
    @process = Bizflow::Lib::ProcessBuilder.new.build(process_bp.id, 1)
    @bp = Bizflow::BusinessModel::Process.new(@process)
  end

  it "moves its head to right positions as it progresses" do

    # given
    actions = @bp.actions
    expect(@bp.current).to eq nil
    
    random_user_id = 12

    # when
    @bp.run(random_user_id)

    # then
    expect(@bp.finished_at).to be nil
    expect(@bp.current.name).to eq "action0"

    # when
    Bizflow::BusinessModel::InputAction.wrap(@bp.current).submit_input("action2")
    @bp.reload

    # then
    expect(@bp.current).to eq actions[2]

    # when
    Bizflow::BusinessModel::TaskAction.wrap(@bp.current).finish
    @bp.reload

    # then
    expect(@bp.current).to eq actions[3]

    # when
    Bizflow::BusinessModel::TaskAction.wrap(@bp.current).finish
    @bp.reload

    # then
    expect(@bp.current).to eq nil
    expect(@bp.finished_at).to_not be nil

  end

  it "creates tasks as it progresses by finishing tasks" do

    # when
    @bp.run(12)

    # then
    tasks = Bizflow::DataModel::Task.where(finished_at: nil)
    expect(tasks.map(&:name)).to eq []

    # when
    Bizflow::BusinessModel::InputAction.wrap(@bp.current).submit_input("action2")

    # then
    tasks = Bizflow::DataModel::Task.where(finished_at: nil)
    expect(tasks.map(&:name)).to eq ["task3"]

    # when
    Bizflow::BusinessModel::Task.wraps(tasks).each { |bt| bt.finish }

    # then
    tasks = Bizflow::DataModel::Task.where(finished_at: nil)
    expect(tasks.map(&:name)).to eq ["task4"]

    # when
    Bizflow::BusinessModel::Task.wraps(tasks).each { |bt| bt.finish }

    # then
    tasks = Bizflow::DataModel::Task.where(finished_at: nil)
    expect(tasks.map(&:name)).to eq []
    @bp.reload
    expect(@bp.finished_at).to_not be nil

  end

  it "follows runned_at, jumped_at times" do

    @bp.run(140)

    expect(@bp.runned_at).to_not be nil

    Bizflow::BusinessModel::TaskAction.wrap(@bp.actions[0]).finish

    expect(@bp.jumped_at).to_not be nil

  end

end
