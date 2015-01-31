require "spec_helper"

require "bizflow/business/business_process"

describe Bizflow::Business::BusinessProcess, process: true do

  let(:processbp_jukebox) { double(name: "jukebox") }

  let(:block_bp_pay) { double(name: "pay", type: "task") }
  let(:task_bp_pay) { double(id: 1, name: "pay", role: "client", block_blueprint: block_bp_pay) }

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
  let(:ph) { double(block: block_pay, process: process_jukebox) }  
  let(:process) { Bizflow::Business::BusinessProcess.wrap(process_jukebox) }

  before :each do

    allow(process_jukebox).to receive(:process_heads) { [ph] }
    allow(block_bp_pay).to receive(:task_blueprints) { [task_bp_pay] }

  end

  it "can run" do

    expect(block_pay).to receive(:add_task)
    process.run
  
  end

  it "can finish" do
  
    expect(process.respond_to? :finish).to be(true)
  
  end

end
