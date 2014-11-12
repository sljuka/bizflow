
class Bizflow::DomainRepo

  attr_accessor :processes, :handlers

  def initialize

    @processes = {}
    @handlers = {}

  end

  def add_process(process)
    @processes[process.name] = process
  end


end