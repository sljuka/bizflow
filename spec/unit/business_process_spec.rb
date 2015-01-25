require "spec_helper"

#require "bizflow/business/business_process"
#require_relative "testing_example/make_breakfast_process"

# describe Bizflow::BusinessProcess do

  # let(:process_raw) { double(primary_key: 1, type: "process_1", creator_id: 1, runner_id: nil, created_at: Time.now, runned_at: nil, jumped_at: nil) }
  # let(:process) { MakeBreakfastProcess.wrap(process_raw) }

  # it "can run" do
  #   expect(process.respond_to? :run).to be(true)
  # end

  # it "can reach down to underlying database object" do
  #   expect(process.primary_key).to be 1
  #   expect(process.type).to eq "process_1"
  #   expect(process.creator_id).to be 1
  #   expect(process.process_heads).to eq []
  #   expect(process.blocks).to eq []
  # end

  # it "can finish" do
  #   expect(process.respond_to? :finish).to be(true)
  # end

# end

# primary_key :id
# String :type, :null=>false
# Integer :creator_id, :null=>false
# Integer :runner_id
# DateTime :created_at, default: Sequel::CURRENT_TIMESTAMP
# DateTime :runned_at
# DateTime :jumped_at
