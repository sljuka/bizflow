require "spec_helper"

require "bizflow/business/process"
require "bizflow/fakes/head"

describe Bizflow::Business::Process, process: true do

  let(:processbp_jukebox) { double(name: "jukebox") }

  let(:action_bp_pay) { double(name: "pay", type: "task") }
  let(:task_bp_pay) { double(id: 1, type: "auto", name: "pay", role: "client", action_blueprint: action_bp_pay) }

  let(:process_jukebox) {
    double(
      name: "jukebox",
      creator_id: 1,
      runner_id: nil,
      created_at: Time.now,
      runned_at: nil,
      jumped_at: nil,
      start_action: "action1",
      actions: [],
      process_blueprint: processbp_jukebox)
  }

  let(:action_pay) { double(name: "pay", type: "task", action_blueprint: action_bp_pay) }
  let(:process_head) { Bizflow::Fakes::Head.new(process, action_pay) }  
  let(:process) { Bizflow::Business::Process.wrap(process_jukebox) }

  before :each do

    allow(processbp_jukebox).to receive(:action_blueprints) { [action_bp_pay, task_bp_pay] }

    allow(process_jukebox).to receive(:process_heads) { [process_head] }
    allow(process_jukebox).to receive(:add_action) { [] }
    allow(process_jukebox).to receive(:add_process_head) { [process_head] }
    
    allow(action_bp_pay).to receive(:task_blueprints) { [task_bp_pay] }
    allow(action_pay).to receive(:add_task)

  end

  it "can run" do
    process.run
    expect(action_pay).to have_received(:add_task)
  end

  it "can finish" do
    expect(process.respond_to? :finish).to be(true)  
  end

end
