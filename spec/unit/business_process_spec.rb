require "spec_helper"

require "bizflow/business/process"
require "bizflow/business/handler"
require "bizflow/fakes/head"
require "bizflow/fakes/action"
require "bizflow/fakes/action_blueprint"
require "bizflow/fakes/handler"
require "bizflow/fakes/handler_blueprint"

describe Bizflow::Business::Process, process: true do

  let(:action_bp_find)    { Bizflow::Fakes::ActionBlueprint.new(nil, "find", "task", nil) }
  let(:task_bp_find)      { Bizflow::Fakes::TaskBlueprint.new(action_bp_find, "find", "staff") }
  let(:action_bp_check)   { Bizflow::Fakes::ActionBlueprint.new(nil, "check", "auto", nil) }
  let(:handler_bp_check)  { Bizflow::Fakes::HandlerBlueprint.new(action_bp_check, "check", "library") }
  let(:action_check)      { Bizflow::Fakes::Action.new(process_jukebox, action_bp_check, "check", "auto") }
  let(:action_find)       { Bizflow::Fakes::Action.new(process_jukebox, action_bp_find, "find", "task") }
  let(:head)              { Bizflow::Fakes::Head.new(process) }
  let(:task)              { Bizflow::Fakes::Task.new(action_find, "find", true) }
  
  let(:handler)           { Bizflow::Fakes::Handler.new(action_check, "check", "library") }
  let(:process_jukebox)   { Bizflow::Fakes::Process.new("jukebox", nil) }
  let(:process)           { Bizflow::Business::Process.wrap(process_jukebox) }

  before :each do

    allow(process_jukebox).to receive(:heads) { [head] }
    allow(process_jukebox).to receive(:actions) { [action_find, action_check] }
    allow(process_jukebox).to receive(:start_action) { action_check }
    allow(action_bp_find).to receive(:task_blueprints) { [task_bp_find] }
    allow(action_bp_check).to receive(:handler_blueprints) { [handler_bp_check] }
    allow(action_check).to receive(:handlers) { [handler] }

    expect_any_instance_of(Bizflow::Business::Handler).to receive(:handle).and_return("find")

  end

  it "can run" do
    expect(handler).to receive(:finished=).and_call_original
    expect(action_find).to receive(:add_task).and_call_original
    process.run
  end

end
