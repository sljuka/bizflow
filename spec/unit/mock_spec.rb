require "spec_helper"

require "bizflow/business/process"
require 'bizflow/repo/test_repo'

describe Bizflow::Business::Process, process2: true do

  let(:process) { double(name: "process")}
  let(:repo) { double(create_process: process, role: "staff", description: "checks the book") }

  it "does some crazy funk with mocks" do
    
  end

end
