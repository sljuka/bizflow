require "spec_helper"
require "bizflow/source_generator"

describe Bizflow::SourceGenerator do

  let(:builder) { Bizflow::DomainBuilder.new("#{File.dirname(__FILE__)}/biz_definition") }
  let(:generator) { Bizflow::SourceGenerator.new(builder) }

  around :each do |example|
    FileUtils.rm_rf("#{File.dirname(__FILE__)}/source_test/.", secure: true)
    example.run
    #FileUtils.rm_rf("#{File.dirname(__FILE__)}/source_test/.", secure: true)
  end

  it "generates source code" do

    generator.generate("#{File.dirname(__FILE__)}/source_test")

  end

end
