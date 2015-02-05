require "spec_helper"

require "bizflow/business/process"
require "bizflow/fakes/head"

describe Bizflow::Business::Process, process: true do

  let(:task_bp_find) { double(id: 1, name: "find", role: "staff") }
  let(:action_bp_find) { double(name: "find", type: "task", task_blueprints: [task_bp_find]) }

  let(:action_bp_check) { double(name: "check", type: "auto") }
  let(:handler_bp_check) { double(name: "check", namespace: "library", action_blueprint: action_bp_check) }  

  #let(:action_find) { double(name: "find", type: "task", action_blueprint: action_bp_find, process: process_jukebox) }
  let(:action_check) { double(name: "check", type: "auto", action_blueprint: action_bp_check, process: process_jukebox) }

  let(:process_jukebox) {
    double(
      name: "jukebox",
      creator_id: 1,
      runner_id: nil,
      created_at: Time.now,
      runned_at: nil,
      jumped_at: nil
    )
  }

  let(:action_find) { Bizflow::Fakes::Action.new(process_jukebox, action_bp_find, "find", "task") }
  let(:head) { Bizflow::Fakes::Head.new(process, action_find) }
  let(:process) { Bizflow::Business::Process.wrap(process_jukebox) }
  let(:task) { Bizflow::Fakes::Task.new(action_find, "find") }

  before :each do

    allow(process_jukebox).to receive(:heads) { [head] }
    allow(process_jukebox).to receive(:actions) { [action_find, action_check] }
    allow(process_jukebox).to receive(:start_action) { action_find }

  end

  it "can run" do
    expect(action_find).to receive(:add_task).and_call_original
    process.run
  end

end
