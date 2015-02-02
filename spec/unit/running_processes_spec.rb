require "spec_helper"

require "bizflow/business/process"
require 'bizflow/repo/test_repo'

describe Bizflow::Business::Process, process2: true do

  let(:task_bp_pay) { double(type: "auto", name: "pay", role: "client", description: "a task") }
  let(:block_bp_pay) { double(name: "pay", type: "task", task_blueprints: [task_bp_pay]) }
  let(:processbp_jukebox) { double(name: "jukebox", description: "process description", start_block: "pay", block_blueprints: [block_bp_pay]) }

  let(:repo) { Bizflow::TestRepo.new([processbp_jukebox]) }
  #let(:process) { nil }

  it "can be created prepare" do
    process = repo.create_process("jukebox")
    pp process
  end

end
