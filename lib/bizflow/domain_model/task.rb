class Bizflow::Task

  attr_accessor :name, :description, :roles

  def initialize(name, options)
    @name = name
    @roles = options[:roles]
    @description = options[:description]
  end

end