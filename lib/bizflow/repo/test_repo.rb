require_relative "bf_repo"

repo = Bizflow::BfRepo.new("/home/pecina/projects/bizflow-api")


#puts repo.read('processes')

puts repo.create('processes', {process_type: "order", val: 12})
