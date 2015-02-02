require "spec_helper"

require "bizflow/business/process"

describe Bizflow::Business::Process, process: true do

  let(:processbp_jukebox) { double(name: "jukebox") }

  let(:block_bp_pay) { double(name: "pay", type: "task") }
  let(:task_bp_pay) { double(id: 1, type: "auto", name: "pay", role: "client", block_blueprint: block_bp_pay) }

  let(:process_jukebox) {
    double(
      name: "jukebox",
      creator_id: 1,
      runner_id: nil,
      created_at: Time.now,
      runned_at: nil,
      jumped_at: nil,
      start_block: "block1",
      blocks: [],
      process_blueprint: processbp_jukebox)
  }

  let(:block_pay) { double(name: "pay", type: "task", block_blueprint: block_bp_pay) }
  let(:process_head) { Fakes::Header.new(process, block_pay) }  
  let(:process) { Bizflow::Business::Process.wrap(process_jukebox) }

  before :each do

    allow(processbp_jukebox).to receive(:block_blueprints) { [block_bp_pay, task_bp_pay] }

    allow(process_jukebox).to receive(:process_heads) { [process_head] }
    allow(process_jukebox).to receive(:add_block) { [] }
    allow(process_jukebox).to receive(:add_process_head) { [process_head] }
    
    allow(block_bp_pay).to receive(:task_blueprints) { [task_bp_pay] }
    allow(block_pay).to receive(:add_task)

  end

  it "can prepare" do
    process.prepare
    expect(process_jukebox).to have_received(:add_process_head)
  end

  it "can run" do
    process.run
    expect(block_pay).to have_received(:add_task)
  end

  it "can finish" do
    expect(process.respond_to? :finish).to be(true)  
  end

end
