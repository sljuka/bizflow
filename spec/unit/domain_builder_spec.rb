require "spec_helper"

require "bizflow/domain_model/domain_repo"
require "bizflow/domain_builder"

describe Bizflow::DomainBuilder do

  let(:repo)    { Bizflow::DomainRepo.new }
  let(:builder) { Bizflow::DomainBuilder.new(File.expand_path("#{File.dirname(__FILE__)}/biz_definition")) }

  before :each do
    builder.repo = repo
  end

  # it "calls interpreters while building the the domain" do
  #   builder.domain_interpreter = domain_interpreter
  #   expect(domain_interpreter).to receive(:process)
  #   builder.build

  # end

  it "fills the repo with processes while building the domain" do

    builder.build
    expect(repo.processes.count).to eq(1)
    
    expect(repo.processes[:make_breakfast].name).to eq("make_breakfast")
    expect(repo.processes[:make_breakfast].description).to eq("creates breakfast")
    expect(repo.processes[:make_breakfast].start_block).to eq("check_supplies")
    expect(repo.processes[:make_breakfast].roles).to eq(["kitchen"])
    expect(repo.processes[:make_breakfast].namespace).to eq("breakfast")

    expect(repo.processes[:make_breakfast].automated_blocks.count).to eq(2)
    expect(repo.processes[:make_breakfast].task_blocks.count).to eq(2)

  end

  it "fills the domain repo with automated blocks" do

    builder.build

    check_supplies = repo.processes[:make_breakfast].automated_blocks[:check_supplies]
    
    expect(check_supplies.name).to eq("check_supplies")
    expect(check_supplies.description).to eq("checks if there are enaugh eggs, bacon and bread")
    expect(check_supplies.handler.full_name).to eq("breakfast:check_supplies")
    expect(check_supplies.handler.description).to eq("code which checks the supplies")
    expect(check_supplies.next_blocks).to eq({
      not_enaugh_supplies: "get_supplies",
      enaugh_supplies: "make_breakfast"
    })

    make_breakfast = repo.processes[:make_breakfast].automated_blocks[:make_breakfast]
    expect(make_breakfast.name).to eq("make_breakfast")
    expect(make_breakfast.description).to eq("sets stove, fry eggs, roast bacon")
    expect(make_breakfast.handler.full_name).to eq("breakfast:make_breakfast")
    expect(make_breakfast.handler.description).to eq(nil)
    expect(make_breakfast.next_blocks).to eq({ success: "serve_breakfast" })

  end

  it "fills the domain with task blocks" do

    builder.build

    get_supplies = repo.processes[:make_breakfast].task_blocks[:get_supplies]
    expect(get_supplies.name).to eq("get_supplies")
    expect(get_supplies.description).to eq("get enaugh eggs, bacon and bread")
    expect(get_supplies.tasks.count).to eq(3)
    expect(get_supplies.next_block).to eq("make_breakfast")

    serve_breakfast = repo.processes[:make_breakfast].task_blocks[:serve_breakfast]
    expect(serve_breakfast.name).to eq("serve_breakfast")
    expect(serve_breakfast.description).to eq("prepare table, slice bread")
    expect(serve_breakfast.tasks.count).to eq(2)
    expect(serve_breakfast.next_block).to eq("process:finish")

  end



end