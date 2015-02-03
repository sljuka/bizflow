require "spec_helper"

require "bizflow/domain/domain_repo"
require "bizflow/domain_builder"

describe Bizflow::DomainBuilder do

  let(:repo)    { Bizflow::Domain::DomainRepo.new }
  let(:builder) { Bizflow::DomainBuilder.new(File.expand_path("#{File.dirname(__FILE__)}/biz_definition")) }

  before :each do
    builder.repo = repo
  end

  it "fills the repo with processes while building the domain" do

    builder.build
    expect(repo.processes.count).to eq(1)
    
    expect(repo.processes[0].name).to eq("make_breakfast")
    expect(repo.processes[0].description).to eq("creates breakfast")
    expect(repo.processes[0].start_action).to eq("check_supplies")

    expect(repo.processes[0].actions.count).to eq(4)

  end

  it "fills the domain repo with automated actions" do

    builder.build

    check_supplies = repo.processes[0].actions.select { |item| item.name == "check_supplies" }.first
    
    expect(check_supplies.name).to eq("check_supplies")
    expect(check_supplies.description).to eq("checks if there are enaugh eggs, bacon and bread")
    
    expect(check_supplies.handler.name).to eq("check_supplies")
    expect(check_supplies.handler.namespace).to eq("breakfast")
    expect(check_supplies.handler.description).to eq("code which checks the supplies")
    expect(check_supplies.next_actions).to eq({
      not_enaugh_supplies: "get_supplies",
      enaugh_supplies: "make_breakfast"
    })

    make_breakfast = repo.processes[0].actions.select { |item| item.name == "make_breakfast" }.first
    expect(make_breakfast.name).to eq("make_breakfast")
    expect(make_breakfast.description).to eq("sets stove, fry eggs, roast bacon")
    expect(make_breakfast.handler.name).to eq("make_breakfast")
    expect(make_breakfast.handler.namespace).to eq("breakfast")
    expect(make_breakfast.handler.description).to eq(nil)
    expect(make_breakfast.next_actions).to eq({ success: "serve_breakfast" })

  end

  it "fills the domain with task actions" do

    builder.build

    get_supplies = repo.processes[0].actions.select { |item| item.name == "get_supplies" }.first
    expect(get_supplies.name).to eq("get_supplies")
    expect(get_supplies.description).to eq("get enaugh eggs, bacon and bread")
    expect(get_supplies.tasks.count).to eq(3)
    expect(get_supplies.next_action).to eq("make_breakfast")

    serve_breakfast = repo.processes[0].actions.select { |item| item.name == "serve_breakfast" }.first
    expect(serve_breakfast.name).to eq("serve_breakfast")
    expect(serve_breakfast.description).to eq("prepare table, slice bread")
    expect(serve_breakfast.tasks.count).to eq(2)
    
    task = serve_breakfast.tasks.select {|item| item.name == "slice_bread"}.first
    expect(task.roles).to eq(["kitchen"])
    
    expect(serve_breakfast.next_action).to eq("process:finish")

  end



end