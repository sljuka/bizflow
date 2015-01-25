# require "spec_helper"
# require "bizflow/source_generator"

# describe Bizflow::SourceGenerator do

#   let(:builder) { Bizflow::DomainBuilder.new("#{File.dirname(__FILE__)}/biz_definition") }
#   let(:generator) { Bizflow::SourceGenerator.new(builder) }

#   around :each do |example|
#     FileUtils.rm_rf("#{File.dirname(__FILE__)}/source_test/.", secure: true)
#     example.run
#     FileUtils.rm_rf("#{File.dirname(__FILE__)}/source_test/.", secure: true)
#   end

#   it "generates process source code" do

#     process_path = "#{File.dirname(__FILE__)}/source_test"
    
#     generator_config = {
#       dest_process_path: process_path,
#       dest_handler_path: process_path,
#       dest_descriptor_path: process_path
#     }

#     generator.generate(generator_config)
#     process_source_files = Dir.glob("#{process_path}/**/*[.json|.rb]").map {|path| File.basename(path)}
#     process_descriptor_files = Dir.glob("#{process_path}/**/*[.json|.rb]").map {|path| File.basename(path)}
#     expect(process_descriptor_files).to include "process-descriptor.json"
#     expect(process_source_files).to include "make_breakfast_process.rb"

#   end

#   it "generates handler source code" do

#     process_path = "#{File.dirname(__FILE__)}/source_test"
    
#     generator_config = {
#       dest_process_path: process_path,
#       dest_handler_path: process_path,
#       dest_descriptor_path: process_path
#     }

#     generator.generate(generator_config)
#     process_source_files = Dir.glob("#{process_path}/**/*[.json|.rb]").map {|path| File.basename(path)}
#     process_descriptor_files = Dir.glob("#{process_path}/**/*[.json|.rb]").map {|path| File.basename(path)}
#     expect(process_descriptor_files).to include "process-descriptor.json"
#     expect(process_source_files).to include "make_breakfast_process.rb"    

#   end

# end
