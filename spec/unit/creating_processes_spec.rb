require "spec_helper"

require "bizflow/business/process"
require 'bizflow/repo/test_repo'

describe Bizflow::Business::Process, process2: true do

  let(:task_bp_find) { double(name: "find_book", role: "staff", description: "checks the book") }
  let(:handler_bp_check) { double(name: "check_book", namespace: "library", description: "sets the book as checked out, and sets the date of checking and date of return.")}
  let(:action_bp_find) { double(name: "find", type: "task", task_blueprints: [task_bp_find]) }
  let(:action_bp_check) { double(name: "check", type: "auto", handler_blueprints: [handler_bp_check]) }
  let(:process_bp_jukebox) { double(name: "jukebox", description: "process description", start_action: "find", action_blueprints: [action_bp_find, action_bp_check]) }

  let(:repo) { Bizflow::TestRepo.new([process_bp_jukebox]) }

  it "can be created prepare" do
    process = repo.create_process("jukebox")
    pp process
  end

end
