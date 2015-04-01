require "bizflow/semantic_model/domain_repo"
require "bizflow/lib/semantic_builder"

describe Bizflow::Lib::SemanticBuilder, interpreter: true do

  before :each do
    @repo = Bizflow::SemanticModel::DomainRepo.new
    @builder = Bizflow::Lib::SemanticBuilder.new(File.expand_path("#{File.dirname(__FILE__)}/../dsl_scripts/breakfast"))
    @builder.repo = @repo
  end

  it "fills the semantic repo with processes while building the semantic model" do

    @builder.build
    expect(@repo.processes.count).to eq(1)
    
    process = @repo.processes[0]

    expect(process.name).to eq("make_breakfast")
    expect(process.description).to eq("creates breakfast")
    expect(process.start).to eq("check_supplies")

  end

  it "fills the semantic repo with actions" do

    @builder.build
    process = @repo.processes[0]
    actions = process.actions

    expect(actions.count).to eq 4

    # name
    expect(actions.map(&:name)).to eq(["check_supplies", "get_supplies", "make_breakfast", "serve_breakfast"])
    expect(actions.map(&:type)).to eq(["input", "task", "task", "task"])
    
    # descritpion
    expect(actions.map(&:description)).to eq([
      "checks if there are enaugh eggs, bacon and bread",
      "get enaugh eggs, bacon and bread",
      "sets stove, fry eggs, roast bacon",
      nil
    ])

    input_actions = actions.select { |a| a.type == "input"}.first
    expect(input_actions.next_actions).to eq(
      not_enaugh_supplies: "get_supplies",
      enaugh_supplies: "make_breakfast"
    )

    task_action_next_actions = actions.select { |a| a.type == "task"}.map(&:next_action)
    expect(task_action_next_actions).to eq ["make_breakfast", "serve_breakfast", "process:finish"]

  end

  it "fills the semantic repo with tasks" do

    @builder.build
    process = @repo.processes[0]
    actions = process.actions
    tasks = actions.select { |a| a.type == "task" }.map(&:tasks).flatten

    expect(tasks.count).to eq(6)

    expect(tasks.map(&:name)).to eq(["get_bacon", "get_eggs", "get_bread", "make_breakfast", "prepare_table", "slice_bread"])
    
    expect(tasks.map(&:description)).to eq([
      "optional description",
      nil,
      nil,
      nil,
      nil,
      nil
    ])

    expect(tasks.map(&:auto_assign)).to eq([
      true,
      false,
      false,
      false,
      false,
      false
    ])

    expect(tasks.map {|t| [t.name, t.roles]}).to eq([
      ["get_bacon", ["storage", "kitchen"]],
      ["get_eggs", ["storage", "kitchen"]],
      ["get_bread", ["storage"]],
      ["make_breakfast", ["kitchen"]],
      ["prepare_table", ["servers"]],
      ["slice_bread", ["kitchen"]]
    ])

  end



end