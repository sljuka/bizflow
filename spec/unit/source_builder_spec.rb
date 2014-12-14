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

  it "generates process source code" do

    source_path = "#{File.dirname(__FILE__)}/source_test"
    generator.generate(source_path)
    process_source_files = Dir["#{source_path}/**/*.rb"].map {|path| File.basename(path)}
    expect(process_source_files).to include "make_breakfast.rb"

  end

  it "generates handler source code" do

    source_path = "#{File.dirname(__FILE__)}/source_test"
    generator.generate(source_path)
    process_source_files = Dir["#{source_path}/**/*.rb"].map {|path| File.basename(path)}
    expect(process_source_files).to include "make_breakfast.rb"    

  end

end
