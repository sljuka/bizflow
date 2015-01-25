require "spec_helper"

require "bizflow/business/business_process"
require "bizflow/business/task"
require "bizflow/business/task_block"
require "bizflow/business/automated_block"
require "bizflow/business/process_head"

describe Bizflow::Business::BusinessProcess, process: true do
  
  let(:block_raw_1) { double(primary_key: 1, name: "block1", type: "task") }
  let(:block_raw_2) { double(primary_key: 1, name: "block2", type: "task") }

  let(:block_raw_3) { double(primary_key: 1, name: "block3", type: "auto") }
  let(:block_raw_4) { double(primary_key: 1, name: "block4", type: "auto") }

  let(:process_head_raw) { double(block: block_raw_1) }

  let(:process_raw) {
    double(
      primary_key: 1, type: "process_1", creator_id: 1,
      runner_id: nil, created_at: Time.now, runned_at: nil,
      jumped_at: nil, process_head: process_head_raw, start_block: "block1",
      blocks: [block_raw_1, block_raw_2, block_raw_3, block_raw_4] )
  }
  
  let(:process) { Bizflow::Business::BusinessProcess.wrap(process_raw) }

  it "can run" do
    expect(process.respond_to? :run).to be(true)
  end

  it "runs" do
    expect(block_raw_1).to receive(:add_task).exactly(2).times
    process.run
  end

  it "can reach down to underlying database object" do
    expect(process.primary_key).to be 1
    expect(process.type).to eq "process_1"
    expect(process.creator_id).to be 1
    expect(process.process_head).to eq process_head_raw
    expect(process.blocks).to eq [block_raw_1, block_raw_2, block_raw_3, block_raw_4]
  end

  it "can finish" do
    expect(process.respond_to? :finish).to be(true)
  end

end
