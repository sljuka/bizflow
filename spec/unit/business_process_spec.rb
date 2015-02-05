require "spec_helper"

require "bizflow/business/process"
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
  let(:head)              { Bizflow::Fakes::Head.new(process, action_find) }
  let(:task)              { Bizflow::Fakes::Task.new(action_find, "find") }
  
  let(:process_jukebox)   { Bizflow::Fakes::Process.new("jukebox", nil) }
  let(:process)           { Bizflow::Business::Process.wrap(process_jukebox) }

  before :each do

    allow(process_jukebox).to receive(:heads) { [head] }
    allow(process_jukebox).to receive(:actions) { [action_find, action_check] }
    allow(process_jukebox).to receive(:start_action) { action_find }
    allow(action_bp_find).to receive(:task_blueprints) { [task_bp_find] }
    allow(action_bp_check).to receive(:handler_blueprints) { [handler_bp_check] } 

  end

  it "can run" do
    expect(action_find).to receive(:add_task).and_call_original
    process.run
  end

end
