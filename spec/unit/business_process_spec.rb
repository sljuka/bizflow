require "spec_helper"

require "bizflow/business/business_process"

describe Bizflow::Business::BusinessProcess, process: true do

  let(:processbp_jukebox) { double(name: "jukebox") }
  let(:blockbp_pay) { double(name: "pay", type: "task") }
  let(:taskbp_pay) { double(id: 1, name: "pay", role: "client", block_blueprint: blockbp_pay) }

  # let(:block_bp1) { double(name: "block_bp1", type: "auto", process_blueprint: process_bp, handler_blueprints: [handler_bp1]) }
  # let(:block_bp2) { double(name: "block_bp2", type: "task", process_blueprint: process_bp, task_blueprints: [task_bp1]) }
  # let(:block_bp3) { double(name: "block_bp3", type: "auto", process_blueprint: process_bp, handler_blueprints: [handler_bp2]) }
  # let(:block_bp4) { double(name: "block_bp4", type: "task", process_blueprint: process_bp, task_blueprints: [task_bp2]) }

  # let(:handler_bp1) { double(path: "path/to/var", constant: "Some::Constant", block_blueprint: block_bp1) }
  # let(:handler_bp2) { double(path: "path/to/var2", constant: "Some::Constant2", block_blueprint: block_bp3) }

  # let(:block_2) { double(name: "block2", type: "task", block_blueprint: block_bp4) }

  # let(:block_raw_3) { double(name: "block3", type: "auto", block_blueprint: block_bp1) }
  # let(:block_raw_4) { double(name: "block4", type: "auto", block_blueprint: block_bp3) }

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

  let(:block_pay) { double(name: "pay", type: "task", block_blueprint: blockbp_pay) }
  let(:ph) { double(block: block_pay, process: process_jukebox) }  

  let(:process) { Bizflow::Business::BusinessProcess.wrap(process_jukebox) }

  it "can run" do
    expect(process_jukebox).to receive(:process_heads) { [ph] }
    expect(blockbp_pay).to receive(:task_blueprints) { [taskbp_pay] }
    expect(block_pay).to receive(:add_task)
    process.run
  end

  it "can finish" do
    expect(process.respond_to? :finish).to be(true)
  end

end
