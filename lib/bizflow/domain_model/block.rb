class Bizflow::Block

  attr_reader :name, :description

  def initialize(name)
    @name = name
    @description = nil
  end

end