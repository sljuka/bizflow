require "spec_helper"

require "bizflow/domain_repo"
require "bizflow/domain_builder"

describe Bizflow::DomainBuilder do

  let(:repo)    { Bizflow::DomainRepo.new }
  let(:builder) { Bizflow::DomainBuilder.new(repo, File.expand_path("#{File.dirname(__FILE__)}/biz_definition")) }
  let(:domain_incubator) { double(block: true)}

  # it "calls incubators while building the the domain" do
  #   builder.domain_incubator = domain_incubator
  #   expect(domain_incubator).to receive(:process)
  #   builder.build

  # end

  it "fills the repo while building the domain" do

    builder.build
    expect(repo.processes.count).to eq(1)

  end



end