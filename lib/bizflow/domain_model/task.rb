class Bizflow::Task

  attr_accessor :name, :description, :roles

  def initialize(name, roles, description = nil)
    @name = name
    @roles = roles
    @description = description
  end

end