require 'bizflow/domain_builder'
require 'bizflow/source_generator'

class Bizflow::BuildCommand

  def self.run(command, args)
    source_path = "#{Dir.pwd}/#{args[0]}"
    dest_path = "#{Dir.pwd}/#{args[1]}"
    db = Bizflow::DomainBuilder.new(source_path)
    sg = Bizflow::SourceGenerator.new(db)

    sg.generate(dest_path)
    puts "processes built in #{dest_path}"
  end


end