require_relative "repo"

repo = Bizflow::Repo.new("/home/pecina/projects/bizflow-api")


#puts repo.read('processes')

puts repo.create('processes', {process_type: "order", val: 12}).map(&:type)
