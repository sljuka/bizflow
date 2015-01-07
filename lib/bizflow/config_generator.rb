module Bizflow
  class ConfigGenerator

    RbTemplatesPath = "#{File.dirname(__FILE__)}/templates/rb"

    def generate
      process_source = ERB.new(File.read("#{RbTemplatesPath}/config.tt"), nil, '-').result()
      out_file = File.new("#{Dir.pwd}/bizflow_config.rb", "w")
      out_file.puts(process_source)
      out_file.close
    end

  end
end
