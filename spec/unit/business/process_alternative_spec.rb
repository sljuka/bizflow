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

    actions = @bp.actions

    # given
    expect(@bp.current).to eq nil    
    random_user_id = 12
    res = nil

    # when
    @bp.run(random_user_id) do |on|

      on.success {
        res = "success"
      }

      on.already_started {
        res = "already_started"
      }

    end

    # then
    expect(res).to eq "success"

  end

end
