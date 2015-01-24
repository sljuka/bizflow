
class Bizflow::DomainRepo

  attr_accessor :processes

  def initialize
    @processes = {}
  end

  def add_process(process)
    @processes[process.name.to_sym] = process
  end

  def get_binding
    binding
  end

end